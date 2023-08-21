Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC2782484
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzSp-0008NE-9B; Mon, 21 Aug 2023 03:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSJ-0008HS-GL
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSE-000627-4s
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/e6bQT8yFt1i+dXQ4vkNXdc4Lagq4aD6RAWxUK6KFLI=;
 b=YCMx8cV3HumFQli/AG9MZKhUFTXAf5WriEcGIQ0uL2wdUi2Zn/NMRyAyAVPB9Xl5bt4RTC
 4QAa/ehN6DK6rYryz/Z5X2SKdzMZCd2hONM2zWA7efiZce4NEDK7rr33wTccAgABMRVz8+
 zoIoPctQF2i1f25/0SIucBLyXpnS7RA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-MtYf93QQNWGDUt6WDe8uhQ-1; Mon, 21 Aug 2023 03:34:54 -0400
X-MC-Unique: MtYf93QQNWGDUt6WDe8uhQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe517ca810so20195265e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603293; x=1693208093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/e6bQT8yFt1i+dXQ4vkNXdc4Lagq4aD6RAWxUK6KFLI=;
 b=fbCyULPHTpZyyND7UCLgVBBHD5qFJ14jPEfZUJqsHA8B00n4LTgmDvpuerbmCufm6v
 ra6XU2v7U89sohjV7syzjEPHUn/t4GeKenyWvgo9RnVcKsPEcRvhamyD0T6zeGIwDXHu
 TQO+hYabeldJJfEx0KgPPQEWgSrhdh/6V4ORru3hymDwHuEDwkmkNu8XtR0Eg3pOOrM6
 HDnhnVVKYBJvbDYqyHFz5Ny//fiEuKT6IJ2teuwUaPwT0tq+LXrl1oZTB3QIRk92dVOb
 us0esB03V2M7lBFXUM9c9Qjjzgn1Oth7GTdFZYFmmyMcD/j7BGJfuYdFDAs2uUQGPJ1t
 UTXQ==
X-Gm-Message-State: AOJu0YxPqTmJv7P0muQcVJcuLMqCthFUetQWa1ln9PKSB7YfJ8Rx5jji
 gpGTKOZiytBewb1/tfSh6nf+MaH3tCsdoURka8YMFxfKQ0LSryfDA+wj4Ccpktu4skl9T2Ngg4Q
 FldxNybH7cvPVkjI=
X-Received: by 2002:a7b:ca50:0:b0:3f9:70f:8b99 with SMTP id
 m16-20020a7bca50000000b003f9070f8b99mr4035956wml.7.1692603293871; 
 Mon, 21 Aug 2023 00:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyVDJuAmnrcsvVpApB7RF94cvF4xJoOX6uOdMY+e9Va1tWzFhhfX+VJPoPCVTCMpQXCDqVaA==
X-Received: by 2002:a7b:ca50:0:b0:3f9:70f:8b99 with SMTP id
 m16-20020a7bca50000000b003f9070f8b99mr4035948wml.7.1692603293725; 
 Mon, 21 Aug 2023 00:34:53 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c22cd00b003fa98908014sm15330109wmg.8.2023.08.21.00.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:34:53 -0700 (PDT)
Message-ID: <a1905884-d15b-1a52-036a-afd455e0d702@redhat.com>
Date: Mon, 21 Aug 2023 09:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/21] preallocate: Factor out
 preallocate_truncate_to_real_size()
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-3-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eesposit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 17/08/2023 um 14:50 schrieb Kevin Wolf:
> It's essentially the same code in preallocate_check_perm() and
> preallocate_close(), except that the latter ignores errors.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


