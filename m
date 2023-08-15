Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459877D625
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2aQ-0002rI-1H; Tue, 15 Aug 2023 18:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2aN-0002iv-F0
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2aK-0005Ei-Nr
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692138738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TK2zpFONuiCyaRN39wi1xAjT8ylm6xM+fFW6BfJ1bvk=;
 b=DOAnUPax7jm4474T8u8pHvH09fg828NyySRxwUjTIsQ1K7vMDHfQT6SAEW/qvKygcvkSlX
 BG3gduBVpxZcAd6GVA7zhkg+9cZqn2Xw2lp0jZx7x2WS5n7noATIr8GCMB8emCNohJ2RGz
 iv2vApbsu3shHc847QbHsSvkiGZMmes=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-JeULxNPWPHqWJfUxH3CCbQ-1; Tue, 15 Aug 2023 18:32:16 -0400
X-MC-Unique: JeULxNPWPHqWJfUxH3CCbQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-40fe7fa05edso17181561cf.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692138736; x=1692743536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TK2zpFONuiCyaRN39wi1xAjT8ylm6xM+fFW6BfJ1bvk=;
 b=bi09ZRJcTSHXCThz7jaxB7rJnfcESaWJHj1oVlHU7RjYHAZhNxutEXhIm1MHPXuLWS
 GY2jIuAuNu1WGOCAmfNQLdEWw8iugELAURvmIW5pot0vH6z2Yb2FOI/gpoM/zMTAGieY
 Fr1Icci5FQnFybKfj3hPt/VLcmybYLBuTXHBgOkSQdjkcUW4YgDLaTByBa7Tbnvh+jEQ
 7lLdRm6E64E1bahZ1ePR1iqdhA39gFb8VL54XFjDTXI9Gy6hel2klM3kinrQwiEX245V
 DlEiDK9d1QoQLhcmviS3Mx74+koP6Br53zbQq5NjyRvt7U9SE+sMMczdJpxgk9tpaGLa
 KQ+w==
X-Gm-Message-State: AOJu0Yy2Ja2DO7hW7CISDtgjN83cVdV26fO8o3VYUrFK7AWW/NyqzhVr
 uvDkaP5r5JvWGCRRE+f/M8Nz1vweJuLh+BRZkfZuCYGn1weQQvdwLV6scu/JycEQJi8UwXKRCrm
 xEy7aGl0MXVuuYNA=
X-Received: by 2002:a05:622a:18a1:b0:403:b188:36cd with SMTP id
 v33-20020a05622a18a100b00403b18836cdmr52763qtc.4.1692138736186; 
 Tue, 15 Aug 2023 15:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG13M8JLEwsDP8upVhUAf384YewpHodSqnwFWfpwvN3myq/E/3T/aH6KoGbGTHmJJc8MjXRSg==
X-Received: by 2002:a05:622a:18a1:b0:403:b188:36cd with SMTP id
 v33-20020a05622a18a100b00403b18836cdmr52747qtc.4.1692138735932; 
 Tue, 15 Aug 2023 15:32:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c16-20020ac87d90000000b00407ffb2c24dsm3646106qtd.63.2023.08.15.15.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:32:15 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:32:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 5/5] migration/ram: Merge save_zero_page functions
Message-ID: <ZNv86AwQoEzJ5eY6@x1n>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815143828.15436-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 15, 2023 at 11:38:28AM -0300, Fabiano Rosas wrote:
> We don't need to do this in two pieces. One single function makes it
> easier to grasp, specially since it removes the indirection on the
> return value handling.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 8ec38f69e8..13935ead1c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1128,32 +1128,6 @@ void ram_release_page(const char *rbname, uint64_t offset)
>      ram_discard_range(rbname, offset, TARGET_PAGE_SIZE);
>  }
>  
> -/**
> - * save_zero_page_to_file: send the zero page to the file
> - *
> - * Returns the size of data written to the file, 0 means the page is not
> - * a zero page
> - *
> - * @pss: current PSS channel
> - * @block: block that contains the page we want to send
> - * @offset: offset inside the block for the page
> - */
> -static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
> -                                  ram_addr_t offset)
> -{
> -    uint8_t *p = block->host + offset;
> -    QEMUFile *file = pss->pss_channel;
> -    int len = 0;
> -
> -    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> -        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
> -        qemu_put_byte(file, 0);
> -        len += 1;
> -        ram_release_page(block->idstr, offset);
> -    }
> -    return len;
> -}
> -
>  /**
>   * save_zero_page: send the zero page to the stream
>   *
> @@ -1167,12 +1141,19 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
>  static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
>                            ram_addr_t offset)
>  {
> -    int len = save_zero_page_to_file(pss, block, offset);
> +    uint8_t *p = block->host + offset;
> +    QEMUFile *file = pss->pss_channel;
> +    int len = 0;
>  
> -    if (!len) {
> -        return -1;
> +    if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> +        return 0;
>      }
>  
> +    len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
> +    qemu_put_byte(file, 0);
> +    len += 1;
> +    ram_release_page(block->idstr, offset);
> +
>      stat64_add(&mig_stats.zero_pages, 1);
>      ram_transferred_add(len);
>  
> @@ -1186,7 +1167,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
>          XBZRLE_cache_unlock();
>      }
>  
> -    return 1;
> +    return len;

I don't think it's correct.. We need to keep the retval definition (how
many pages were sent) rather than returning num of bytes, I think.

I'm curious how did this pass any form of test.. because I think we did
assert that:

            /* Be strict to return code; it must be 1, or what else? */
            if (migration_ops->ram_save_target_page(rs, pss) != 1) {
                error_report_once("%s: ram_save_target_page failed", __func__);
                ret = -1;
                goto out;
            }

Did I miss something?

-- 
Peter Xu


