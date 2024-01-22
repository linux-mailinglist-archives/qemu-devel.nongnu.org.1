Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD7836E39
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyOR-0003Gp-Fh; Mon, 22 Jan 2024 12:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRyOO-0003Cl-Iu
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRyOM-0005Iq-VR
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705945646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/l1KI+0RJHoJN0yuLSmF4yVy3IM0h2lWQ4BPHBMwMdg=;
 b=NsUbJAM5btP0ra7Ep4NWTwm43blEIPyJMr6h7thSTgMZ6o55uyFTrWsu0eNFRean7bjlN+
 9nPA7DQXxnjzYsVtLJiXK5+WtZfKXSI0Wn3NgvSr1QYWhPGY60w7rq29fD22/fB2Gi619k
 rxhzcN/yT4rOSaLJqHpTehCLIScV30s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-_UtOYPwPPVCsApaYOvj68w-1; Mon, 22 Jan 2024 12:47:24 -0500
X-MC-Unique: _UtOYPwPPVCsApaYOvj68w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-42a4660fae8so12075841cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945643; x=1706550443;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/l1KI+0RJHoJN0yuLSmF4yVy3IM0h2lWQ4BPHBMwMdg=;
 b=K6yAy4RiSDfJIICPLDG/vCblnsYcjd7gTOph07+7MKvxmvan9Y5awV44Q3TOKWPLK9
 U+uC96XyjZjt6/xsilcXAwLtARu8PdEVWqjgrYdzxsZB4q9GS9Sdi+JVf2SHJTMRIVad
 mFsHfWdwmzImtgnvLrKFDQWOZpOOZ5ijmPN3GSxSprIhvC1ARcJOHEdtb6BE6DthY0Cx
 JQr0yI12HN/2RCtzrOlLi5tmvIi2tr4vEL7ff06yui47q3o10dF5S/0nEu+lhr31uDcJ
 ifpALjBMarKeIW7K/9/UrW+I1KSkFq8oYdobY1T8+V+k+qaHYm2oGTmpG+LybjTImzo2
 EvpA==
X-Gm-Message-State: AOJu0Yyk/JQBAvqwNVW9mXjOQlbwXSZNspJv71GDRTH6Fz/BQIwD8LvW
 f5uopMO0VH8mK2ydpeQQTeS8/yCA6OHiERDEGKhw7qPGUfQ69jZPcs/+bY9J97CWNZ7vJ3o3YBi
 VFFvwCXGrF2aSTlfE69BsFJsVivSMULTkvg2PnPpynGXHDyEDS5V/
X-Received: by 2002:a05:622a:1d1:b0:42a:3917:9270 with SMTP id
 t17-20020a05622a01d100b0042a39179270mr3647237qtw.55.1705945643591; 
 Mon, 22 Jan 2024 09:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgxoWFjBUuSzfv+5HE6ZJJQTwkw8QEk8VYpRCHeUWIHvO1Qe90N4gsxDoRRi6wirQk84Va5Q==
X-Received: by 2002:a05:622a:1d1:b0:42a:3917:9270 with SMTP id
 t17-20020a05622a01d100b0042a39179270mr3647220qtw.55.1705945643298; 
 Mon, 22 Jan 2024 09:47:23 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 k18-20020ac81412000000b004280cad48basm2662241qtj.77.2024.01.22.09.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 09:47:23 -0800 (PST)
Message-ID: <3f19d597-eef0-486d-8583-2ecb4d0a0554@redhat.com>
Date: Mon, 22 Jan 2024 18:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bswap.h: Fix const_le64() macro
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240122173735.472951-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240122173735.472951-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

On 22/01/2024 18.37, Peter Maydell wrote:
> The const_le64() macro introduced in commit 845d80a8c7b187 turns out
> to have a bug which means that on big-endian systems the compiler
> complains if the argument isn't already a 64-bit type. This hasn't
> caused a problem yet, because there are no in-tree uses, but it
> means it's not possible for anybody to add one without it failing CI.
> 
> This example is from an attempted use of it with the argument '0',
> from the s390 CI runner's gcc:
> 
> ../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
> ../include/qemu/bswap.h:148:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 148 | ((((_x) & 0x00000000000000ffU) << 56) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> ../include/qemu/bswap.h:149:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 149 | (((_x) & 0x000000000000ff00U) << 40) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Fix this by making all the constants in the macro have the ULL
> suffix.  This will cause them all to be 64-bit integers, which means
> the result of the logical & will also be an unsigned 64-bit type,
> even if the input to the macro is a smaller type, and so the shifts
> will be in range.
> 
> Fixes: 845d80a8c7b187 ("qemu/bswap: Add const_le64()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested 'by hand' on the s390 box that was complaining about
> Kevin's pullreq.
> ---
>   include/qemu/bswap.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 933a66ee87e..bd67468e5e4 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -145,14 +145,14 @@ CPU_CONVERT(le, 64, uint64_t)
>    */
>   #if HOST_BIG_ENDIAN
>   # define const_le64(_x)                          \
> -    ((((_x) & 0x00000000000000ffU) << 56) |      \
> -     (((_x) & 0x000000000000ff00U) << 40) |      \
> -     (((_x) & 0x0000000000ff0000U) << 24) |      \
> -     (((_x) & 0x00000000ff000000U) <<  8) |      \
> -     (((_x) & 0x000000ff00000000U) >>  8) |      \
> -     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> -     (((_x) & 0x00ff000000000000U) >> 40) |      \
> -     (((_x) & 0xff00000000000000U) >> 56))
> +    ((((_x) & 0x00000000000000ffULL) << 56) |    \
> +     (((_x) & 0x000000000000ff00ULL) << 40) |    \
> +     (((_x) & 0x0000000000ff0000ULL) << 24) |    \
> +     (((_x) & 0x00000000ff000000ULL) <<  8) |    \
> +     (((_x) & 0x000000ff00000000ULL) >>  8) |    \
> +     (((_x) & 0x0000ff0000000000ULL) >> 24) |    \
> +     (((_x) & 0x00ff000000000000ULL) >> 40) |    \
> +     (((_x) & 0xff00000000000000ULL) >> 56))
>   # define const_le32(_x)                          \
>       ((((_x) & 0x000000ffU) << 24) |              \
>        (((_x) & 0x0000ff00U) <<  8) |              \

Reviewed-by: Thomas Huth <thuth@redhat.com>


