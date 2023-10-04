Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8E7B85B4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo55N-0007no-Ds; Wed, 04 Oct 2023 12:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo55I-0007il-9F
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo55G-0007ul-RZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438250;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nZT5tu5amrs4MKWkeLZ1EJ4h6xeZTUTHLdCZnJKqekI=;
 b=cdWsIioH9eZsokKTL7t9Y4tJbj73hqHdrGr4aubb1KZ6sb/eJ6L/fbFH9nWF47yLxmrOZu
 J2LGY41mcW4zImt3uzmmDXmOur3ZmcBHerW8cWuq8HRnyiPIi5kfknNqFuwfu3laeIo14f
 5bVopbF3La70IuEjSu38B7lSbKs9fwU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-vRDoLiu1PfePe3Kjsk3QQA-1; Wed, 04 Oct 2023 12:50:42 -0400
X-MC-Unique: vRDoLiu1PfePe3Kjsk3QQA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso43481f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438241; x=1697043041;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZT5tu5amrs4MKWkeLZ1EJ4h6xeZTUTHLdCZnJKqekI=;
 b=Zf0nWCRWd3/QPMEDrpQP29ElilPLloyArm3cZ0wn57i2ArrrD0KpZ82dIYSQoQgX3B
 d3IgT6rpDzkDAIXW7CdvKJTj1PoMIKQKRh1HcWYqMUeyODr5zgHdGrP980Qw6jS3gp2o
 ld93dni3fBnhu417IEqlS7IwfY6SN8EooAOXQRMnfm91hIU7W+NvWaY1bLqTWAyRfONu
 ZWvRH6MLauDQMUKeCh/i0rA/ZXZwMhPwmXg8yFBF0pIJpPDXhmBhRGfaflpwwlgQfODz
 z78yi655Oz8JOk+CYWbcDwmoahrD8fyzlfCfNF+RU52Q1e9VU3m/qvlZK0X+gbOlR+f5
 LqYw==
X-Gm-Message-State: AOJu0YxDK3Oe2prviMjmHuGCiSTGqIw1QZIm1rcbm3kod4N4FkgeCHMZ
 /8q2DN8ozPt2qeenAxTYxKDnA7wZcffL07twN0bWjG46fGHa/hNE1/9SpmV1mKw6sdYf/P1nnWa
 QNTHCZFFtPTTNzao=
X-Received: by 2002:a5d:53d1:0:b0:314:1230:29b0 with SMTP id
 a17-20020a5d53d1000000b00314123029b0mr2733765wrw.52.1696438241524; 
 Wed, 04 Oct 2023 09:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3AIufl6lzTPKfRsQLs09dr3zYPKu4zRUGIY/8BaEAtVjiUH5d/7m+ZBT6jGa6TIndwXXzVA==
X-Received: by 2002:a5d:53d1:0:b0:314:1230:29b0 with SMTP id
 a17-20020a5d53d1000000b00314123029b0mr2733746wrw.52.1696438241145; 
 Wed, 04 Oct 2023 09:50:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f16-20020adff590000000b0032326908972sm4395354wro.17.2023.10.04.09.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:50:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 32/53] migration/rdma: Retire macro ERROR()
In-Reply-To: <20230928132019.2544702-33-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:58 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-33-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:50:39 +0200
Message-ID: <874jj6uyao.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> ERROR() has become "error_setg() unless an error has been set
> already".  Hiding the conditional in the macro is in the way of
> further work.  Replace the macro uses by their expansion, and delete
> the macro.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


