Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B057A082D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:57:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnly-0000hW-5S; Thu, 14 Sep 2023 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgnlt-0000fT-6c
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgnlr-0004LS-Ju
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694703399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lczgN869m1B+dZ4pFO9fos+eIlGlOm23knm48OAgWV0=;
 b=BLgHaPCHQcodjg6MBYbmVpygqWWKQRUD1hloMeF1PzRVa2g9oo67TjMUjW5ESe+vKsyD6/
 J8z5pYzq1tRQS+C/PBfy/oOa3GFYSkJffasU4z/wh/6+uJbg7yGNGRs4BAWaayPzDBMG8U
 Ds0oOxviaFXrNie6PCJ993z+rgZ93/Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-1jEOu_7QNbeLuw_-eO4IQw-1; Thu, 14 Sep 2023 10:56:37 -0400
X-MC-Unique: 1jEOu_7QNbeLuw_-eO4IQw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65623d0075aso1486826d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694703397; x=1695308197;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lczgN869m1B+dZ4pFO9fos+eIlGlOm23knm48OAgWV0=;
 b=bP4jsO55kEy3HJY8EBnA+WnfV+jWKYKje9VrxK4jZiHzTCtjeIKFiAOC3N68Y0Hq3N
 ykexW25gFUODN0of96UY72X52KQMdy+8t6+K6rTof9dXnVb8aR1U+om1Vjp3tH0P2TKo
 jOVUyCs1OCulhR9ryIRkso5/e5MbSM2rWvcktkpYz9POjCtGD3s5KMR4+lIvXLMuewuG
 i5KBjuBGXmIiH4D8vW0Mro43T5V7OLDjD5Pw8U/t6RVdQulruNKJAS+PPrcJ08zswQZb
 amPq+pkF1AcWISQjFuhu/PW46IT31WLvQnNgz1YNrpUV1elecVp+glr7YjbpiObomyF8
 GQzA==
X-Gm-Message-State: AOJu0YybBIxIU6A6sGka0Hc13mVaFuyHd+FlFH5Mm2Sa6SsHqzwLd3aD
 o0XNxcSrYeB4misLpC9exPi4tDt3xbPvu9KuprVTj4oObRRjdO+8BokeosM9z/lbwwvxgT0Mm/w
 XigwAB98adxtWTRU=
X-Received: by 2002:a05:6214:76e:b0:63f:7d29:1697 with SMTP id
 f14-20020a056214076e00b0063f7d291697mr5879348qvz.2.1694703397164; 
 Thu, 14 Sep 2023 07:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxHJjt12Mnl7CvzuNdNrZwJCNbSlv98e4um3gtJlL7ivsdhkfzbemJ/sskM+5EZltsIu+krQ==
X-Received: by 2002:a05:6214:76e:b0:63f:7d29:1697 with SMTP id
 f14-20020a056214076e00b0063f7d291697mr5879334qvz.2.1694703396831; 
 Thu, 14 Sep 2023 07:56:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a7-20020a0ca987000000b0063f88855ef2sm519993qvb.101.2023.09.14.07.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 07:56:36 -0700 (PDT)
Date: Thu, 14 Sep 2023 10:56:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
Message-ID: <ZQMfIO3oiqTsawtU@x1n>
References: <20230913192301.GA917052@fedora>
 <87r0n1kggo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0n1kggo.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 13, 2023 at 04:42:31PM -0300, Fabiano Rosas wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > Hi,
> > The following intermittent failure occurred in the CI and I have filed
> > an Issue for it:
> > https://gitlab.com/qemu-project/qemu/-/issues/1886
> >
> > Output:
> >
> >   >>> QTEST_QEMU_IMG=./qemu-img MALLOC_PERTURB_=116 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >   ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >   stderr:
> >   qemu-system-x86_64: Unable to read from socket: Connection reset by peer
> >   Memory content inconsistency at 5b43000 first_byte = bd last_byte = bc current = 4f hit_edge = 1
> >   **
> >   ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
> >   (test program exited with status code -6)
> >
> > You can find the full output here:
> > https://gitlab.com/qemu-project/qemu/-/jobs/5080200417
> 
> This is the postcopy return path issue that I'm addressing here:
> 
> https://lore.kernel.org/r/20230911171320.24372-1-farosas@suse.de
> Subject: [PATCH v6 00/10] Fix segfault on migration return path
> Message-ID: <20230911171320.24372-1-farosas@suse.de>

Hmm I just noticed one thing, that Stefan's failure is a ram check issue
only, which means qemu won't crash?

Fabiano, are you sure it's the same issue on your return-path fix?

I'm also trying to reproduce either of them with some loads.  I think I hit
some but it's very hard to reproduce solidly.

-- 
Peter Xu


