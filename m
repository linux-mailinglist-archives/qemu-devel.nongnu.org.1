Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C998D167
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 12:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwiN-0000l3-A6; Wed, 02 Oct 2024 06:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwiM-0000ku-1J
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwiK-0001q5-Jh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kvxa0vwFNFX0RVdF3FP+KTc0QpzD+S8ueXhkOJ9TGjM=;
 b=Hf1fUw5puvxAVcry5a5kF8rIOZpTjJqvLvmrxIIA/buomz8kWvvvfD6vo7GSf6HJpkk2z9
 gAtpbrhH+aVBIFzt+0rwjAucP3/leN1g3/EhxnyOX4cmNEzqFXchwzOb3hRqnT8pFRBPC1
 i7xiG+wJBs69s7H+zbxno1fDRU/QSZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Ea02YWpvMP6JX6trUIPcsQ-1; Wed, 02 Oct 2024 06:36:10 -0400
X-MC-Unique: Ea02YWpvMP6JX6trUIPcsQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cdb0e9eb7so1697367f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865369; x=1728470169;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kvxa0vwFNFX0RVdF3FP+KTc0QpzD+S8ueXhkOJ9TGjM=;
 b=rrli+2xT/7Wu/eNXy9PpBMFCMMbQ4JIXzECSlqnHNilw9rm8ATZGAejk5T9IjAlQKd
 rFHQRWw7UK8ZDEBvTSLrNySefAn5uMbZsTDRyQUPRb8xBu4s0/Z0EkbUlFnuMohkdEP4
 5Mif5abJyE+M7auDHiMrniJakO2nlStufq84t8rtMGg3fkS9c+BKgJp+JqTqxbe6QRlb
 BwEk6edeF3T0E/rCl9xw2W6acdWUXzOTWCH7HRxACw4FEtx/SEdDYIqQnl4iOmgvjfjb
 KcCvxyJAHk5HnQRSMSqlYhBh6pjOYTWQZr2ipAwBcBb489nxrvf1OeK9/20NUqFxkS3Z
 73gg==
X-Gm-Message-State: AOJu0Yw+0IFWnQnZvjHGEm6YJaGyIW8TP+wdkSqeWOsH0/3YQe8udPGi
 T5nAvOUmsVzk8g8mRt9Yv3KVWnY+MziamI8q2L+nO+oyOSVW688tf9QWTr2+bQ7FLOs6gnf/wVP
 sv1OL23Ji6kUlSiO+rtVrGzqn093AUB1wyDyIHHbzia6eQn+ed2Gh
X-Received: by 2002:adf:cd09:0:b0:374:c101:32 with SMTP id
 ffacd0b85a97d-37cfba0a827mr1461746f8f.46.1727865369472; 
 Wed, 02 Oct 2024 03:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD1axT5kRX+O9naGVftAIsg9U0ih1lYQc6r0QWxHjL8cb//+jU+/wN5uQQlAw6cH/hWDIxqA==
X-Received: by 2002:adf:cd09:0:b0:374:c101:32 with SMTP id
 ffacd0b85a97d-37cfba0a827mr1461729f8f.46.1727865368963; 
 Wed, 02 Oct 2024 03:36:08 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5764c50sm13523670f8f.112.2024.10.02.03.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:36:08 -0700 (PDT)
Message-ID: <8d3023ad-d4c4-4106-ae8f-bf75ac7eff5d@redhat.com>
Date: Wed, 2 Oct 2024 12:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/cursor: remove cursor_get_mono_image
To: dave@treblig.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel@nongnu.org
References: <20240917002318.331010-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240917002318.331010-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/09/2024 02.23, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> cursor_get_mono_image has been unused since 2018's
>    0015ca5cba ("ui: remove support for SDL1.2 in favour of SDL2")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   include/ui/console.h |  1 -
>   ui/cursor.c          | 24 ------------------------
>   2 files changed, 25 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index fa986ab97e..5832d52a8a 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -175,7 +175,6 @@ int cursor_get_mono_bpl(QEMUCursor *c);
>   void cursor_set_mono(QEMUCursor *c,
>                        uint32_t foreground, uint32_t background, uint8_t *image,
>                        int transparent, uint8_t *mask);
> -void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *mask);
>   void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask);
>   
>   typedef void *QEMUGLContext;
> diff --git a/ui/cursor.c b/ui/cursor.c
> index dd3853320d..6e23244fbe 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -197,30 +197,6 @@ void cursor_set_mono(QEMUCursor *c,
>       }
>   }
>   
> -void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *image)
> -{
> -    uint32_t *data = c->data;
> -    uint8_t bit;
> -    int x,y,bpl;
> -
> -    bpl = cursor_get_mono_bpl(c);
> -    memset(image, 0, bpl * c->height);
> -    for (y = 0; y < c->height; y++) {
> -        bit = 0x80;
> -        for (x = 0; x < c->width; x++, data++) {
> -            if (((*data & 0xff000000) == 0xff000000) &&
> -                ((*data & 0x00ffffff) == foreground)) {
> -                image[x/8] |= bit;
> -            }
> -            bit >>= 1;
> -            if (bit == 0) {
> -                bit = 0x80;
> -            }
> -        }
> -        image += bpl;
> -    }
> -}
> -
>   void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
>   {
>       uint32_t *data = c->data;

Reviewed-by: Thomas Huth <thuth@redhat.com>


