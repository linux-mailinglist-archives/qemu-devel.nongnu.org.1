Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B476574B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:20:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP26N-0001ps-AM; Thu, 27 Jul 2023 10:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qP269-0001pA-8p
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qP267-0008MJ-5Z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690468569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVKlUsSSA3xHw1nS4p3mv13mheS7JGW5p8PMpkTpcCc=;
 b=aWCR2HSJfmJXBjbK6ifM1ad/vihW6mlFij6UzNHKNi/LYVQDGK0Ic5WKmEvJCxbNuQDs44
 6j2TQC11hz5r48fqElcSSzWjDzA0ybFPO5/bzgUtwq8TaQ3sRUiuBtUrdTjuhy6Ng1flcd
 FFAxkYXOv9gXq1ejsU8WoQ4CbXWQcQM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-YDJYgaNhMJeM-dmKTSwLww-1; Thu, 27 Jul 2023 10:36:08 -0400
X-MC-Unique: YDJYgaNhMJeM-dmKTSwLww-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-79a1de8b323so29063241.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690468568; x=1691073368;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xVKlUsSSA3xHw1nS4p3mv13mheS7JGW5p8PMpkTpcCc=;
 b=Cn/nihzCatYmNl5WDz/o+X9ZU3Z0doT5UF6e1tmdeSMZPBpWS9H0d4xrg7jeyJRT0N
 q8Xasuvy7X/fE51MvVvaxMAckOIvrE3ily8hLMlou6AP/tRKj0ZAmvKUPKz9QNg9oX4M
 ed6riN8KIXYYZ4gXTF3C6H/pDd40dRWwnilJW7DFvP85fsxwrOpBiQAAwlYVWw9NLYQq
 1xv0O4HTYmFRiIiTI+a3/zBYYw2+3zmWPNNjLHTeLIoV2tFxq8VXKsBjnnzkAGB34beu
 PMRLBJFurfGGq70tiLR19WpriwNUfPtYS4TzXdaCYRPPDOyxZRlo2FWNSThqeMfpGDl9
 zJWg==
X-Gm-Message-State: ABy/qLZFwefcGnENf6BZTnlsAz2szK0/I+dqDE5tKYAnY9hvHl/xK3UJ
 CppgfhNh3JEgb0AmlO5aNd9Ti23LAL4GhLjlvKnRplUrg3ITOXgZhqOxfRuSs6slSjDWuwbk77B
 XtI91+8JbEkq9eBg=
X-Received: by 2002:a05:6122:2387:b0:485:b2ad:bf with SMTP id
 bu7-20020a056122238700b00485b2ad00bfmr2545605vkb.1.1690468567776; 
 Thu, 27 Jul 2023 07:36:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGhcLUlfDH2MxzsJDTE8vVATXiu8/Q5ZiJUeRaHr0tB0+bGSllSCCWe//v7Xe4rW4wO0GS9Zw==
X-Received: by 2002:a05:6122:2387:b0:485:b2ad:bf with SMTP id
 bu7-20020a056122238700b00485b2ad00bfmr2545585vkb.1.1690468567454; 
 Thu, 27 Jul 2023 07:36:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n2-20020a0ce542000000b0061b5dbf1994sm440778qvm.146.2023.07.27.07.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 07:36:07 -0700 (PDT)
Date: Thu, 27 Jul 2023 10:36:06 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmainquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [External] Re: [PATCH] memory: avoid updating ioeventfds for
 some address_space
Message-ID: <ZMKA1n+8tmQC4JLA@x1n>
References: <20230725112037.1762608-1-hongmianquan@bytedance.com>
 <ZMFbxFnv82AWlzLD@x1n>
 <35f53340-dda3-c25d-41c7-b717da6a9121@bytedance.com>
 <ZMJoumdi54neHzkC@x1n>
 <9343c790-7fa6-1f1e-ed1c-2f350de44ec9@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9343c790-7fa6-1f1e-ed1c-2f350de44ec9@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 27, 2023 at 09:23:34PM +0800, hongmainquan wrote:
> 
> 
> 在 2023/7/27 8:53 下午, Peter Xu 写道:
> > On Thu, Jul 27, 2023 at 11:59:43AM +0800, hongmainquan wrote:
> > > 
> > > 
> > > 在 2023/7/27 1:45 上午, Peter Xu 写道:
> > > > On Tue, Jul 25, 2023 at 07:20:37PM +0800, hongmianquan wrote:
> > > > > When updating ioeventfds, we need to iterate all address spaces,
> > > > > but some address spaces do not register eventfd_add|del call when
> > > > > memory_listener_register() and they do nothing when updating ioeventfds.
> > > > > So we can skip these AS in address_space_update_ioeventfds().
> > > > > 
> > > > > The overhead of memory_region_transaction_commit() can be significantly
> > > > > reduced. For example, a VM with 8 vhost net devices and each one has
> > > > > 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
> > > > > 
> > > > > Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> > > > 
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > 
> > > > Should be for 8.2, though.  Please always copy Paolo for memory related
> > > > patches.  I hope Paolo can see this.
> > > > 
> > > Thanks, I hope so. Also, I'm not quite sure what 'Should be for 8.2' means.
> > > Does it imply that there will be changes to this logic after version 8.2?
> > 
> > See:
> > 
> > https://wiki.qemu.org/Planning/8.1
> > 
> > We're already right before 8.1-rc2 release, perf patch isn't normally the
> > target of this phase.
> > 
> > Thanks,
> > 
> Understood. Hope for some suggestions from you.

No further suggestion from my side. You can just keep an eye on this patch
after the 8.1 release - it probably just won't get merged before that.

Some maintainers prefer a resend after the release, but many don't.  It's
optional in this case I think.

Thanks,

-- 
Peter Xu


