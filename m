Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9137CD561
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 09:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt0jW-0003gN-Rq; Wed, 18 Oct 2023 03:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt0jU-0003eo-MZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 03:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt0jT-0008At-1W
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 03:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697613161;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6lO1Z5uouFumWnoaDIBzANoAJylwQYQVtj5Q53e69m4=;
 b=LtmJ3h8jIBNYcExniBt9kKDkX3N0K/R6eCAg6LJiFgAIaHFCRNhfGyUnk5MTr6YN8HhADS
 OyKx85Vxe5HmizGXyuoaOnVOAX9qwPzJb3Csoq/MH98j9gvwBZqK0WDFLgsPlGdG5KrIsZ
 JrkMt/9mmPTT6jjNe0MWg8qLY2AAsvA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-cyx2uPVLMPyeYyg6jjewCQ-1; Wed, 18 Oct 2023 03:12:39 -0400
X-MC-Unique: cyx2uPVLMPyeYyg6jjewCQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4074cdf2566so31830015e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 00:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697613158; x=1698217958;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lO1Z5uouFumWnoaDIBzANoAJylwQYQVtj5Q53e69m4=;
 b=IYfs8OKtbA4r7Yrh5+sSd4jnOsNSiZUoJ4L3N7Hy5OT7yhkMStzd6lXN6Ktb9GVmPf
 NXxFYcMyVM5gGvxP32ss/T8eIOXJX6v4ambWdXg7ynVQW0WELr3lg7QH4noaN95qPSIR
 e73nj1bgyUJ3m3R8VIxalimqZfhSYcJd1bIlStryFZxCren/8vtqqkkzYpKAiCRyJJzl
 WfRnt/iuncBwyVePWjO+FRBi4CVa4YGTY8rbWqB3aDO85ly5k446y+KCxGKs0Q11avlU
 DhlIdlgftSLSDlyCDqh3psOf0HLg0j6yAlcN5FQEH8JD7Zl/10vY1mv+WxPTF7YKmIDC
 KnJw==
X-Gm-Message-State: AOJu0YzwfJFVD1POCNE0vfa3g31Im/fRGcf2StvOtlj7VUcNcKx8NxKz
 /XeRFtu4DLTx+6f444cDa+/pVecsMLoUAUOhNLUt3Kimpvzlynw9F+/2ze/ClezDKc+fNJfhDA6
 dEqxt0Ljf36CzRho=
X-Received: by 2002:a1c:4c08:0:b0:405:29ba:9b5c with SMTP id
 z8-20020a1c4c08000000b0040529ba9b5cmr3678499wmf.16.1697613158466; 
 Wed, 18 Oct 2023 00:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF+yJp65oNGOgmL40DdiL64GXFoIH8EmZIggZt9C8fnRnSUxiCrsrmaObYPl4+lfFMaladiA==
X-Received: by 2002:a1c:4c08:0:b0:405:29ba:9b5c with SMTP id
 z8-20020a1c4c08000000b0040529ba9b5cmr3678487wmf.16.1697613158162; 
 Wed, 18 Oct 2023 00:12:38 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b00405d9a950a2sm852666wml.28.2023.10.18.00.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 00:12:36 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Fix parse_ramblock() on overwritten retvals
In-Reply-To: <20231017203855.298260-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Oct 2023 16:38:55 -0400")
References: <20231017203855.298260-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 09:12:36 +0200
Message-ID: <87r0lsxv2z.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> It's possible that some errors can be overwritten with success retval later
> on, and then ignored.  Always capture all errors and report.
>
> Reported by Coverity 1522861, but actually I spot one more in the same
> function.
>
> Fixes: CID 1522861
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index c844151ee9..d8bdb53a8f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3888,6 +3888,8 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>          ret = qemu_ram_resize(block, length, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> +            assert(ret < 0);
> +            return ret;

I hate that assert.  If you really want that:


         if (ret < 0) {
            error_report_err(local_err);
            assert(ret < 0);
            return ret;
         }

Rest of the patch looks ok.

Later, Juan.


