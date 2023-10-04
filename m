Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E48F7B8325
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3OS-00021r-EA; Wed, 04 Oct 2023 11:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3OI-0001yG-Ca
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3O4-00067y-4I
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R/vdOOPI0NTXoXNq4Dw6+IxBUm/A9HI86C2vJ8nOq5A=;
 b=Df5QCmOiTDHdCN0mdIOOzieSzDsaLCVDLdPT4oG6nsMwvayLx0Fls4q/Mjh8Myk8NfqqAw
 jPTEsgiphXkwlSR8WGO8Sum8gbPOc8KHHKLFakSxJQdwefLUD/5lTFgkEefM2bojOTPrfj
 cIBqzX08Io837S1+LtSA4kzhDJrd2V8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-S9g9Ru05OpidnuAv6wO5Mg-1; Wed, 04 Oct 2023 11:01:55 -0400
X-MC-Unique: S9g9Ru05OpidnuAv6wO5Mg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so16360745e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431711; x=1697036511;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/vdOOPI0NTXoXNq4Dw6+IxBUm/A9HI86C2vJ8nOq5A=;
 b=HMuu8+EqUdEoSU2Dp0URp7ub/35m0vsy9IxwKmRt1StypWa6VW7klsT60AAraP7Ls6
 d6aG77i45oePlqBrIFzwWjKF72UMZkA1DWlTN29+2rFIM6J9OLsfioeHrNpVys7ucK+I
 GmIRbE4suPw1LKf57vsaAMyFuYIZqRvIbK7dItUsoFjLOC60qp7/WKUSqKzMqitkCojx
 DXQ/GZ9kjQO0MPiQBng8HTPi9TJsOF25zD1rFiIIksmsdlLuLkxavT5vrdC1i1r0ToBx
 jHcolzq+2eQqMqVAJi0x+rrjvjefTD5TkhcT0aKE60MIOx0YBtf9LFJ2+zCHEWo0vZvZ
 M9fQ==
X-Gm-Message-State: AOJu0YyttLoX+rm8JlIEFS6OrSzSdwcu+P7zS0jJOS8Cme1K4yDfRD0Y
 4HjaExaGzVDPaneCtwv+bNatJPDblX42REgQcb0ONWqaoLh74PFsNJgqgX4pMBD/OW2mcVjV9uw
 koqBrbKzoXtbRitQ=
X-Received: by 2002:a5d:6909:0:b0:317:e542:80a8 with SMTP id
 t9-20020a5d6909000000b00317e54280a8mr2536705wru.15.1696431711666; 
 Wed, 04 Oct 2023 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhry0/XuFACJPBLDXC7veyMl7bk3HrsPkKFvVmLVJyYVOa+ibPL7fTAiPG7aVZFUv/J4Z/og==
X-Received: by 2002:a5d:6909:0:b0:317:e542:80a8 with SMTP id
 t9-20020a5d6909000000b00317e54280a8mr2536647wru.15.1696431710586; 
 Wed, 04 Oct 2023 08:01:50 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 g14-20020a056000118e00b003231ca246b6sm4209617wrx.95.2023.10.04.08.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:01:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 14/53] migration/rdma: Make
 qemu_rdma_buffer_mergeable() return bool
In-Reply-To: <20230928132019.2544702-15-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:40 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-15-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:01:48 +0200
Message-ID: <87lecixwgz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> qemu_rdma_buffer_mergeable() is semantically a predicate.  It returns
> int 0 or 1.  Return bool instead, and fix the function name's
> spelling.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


