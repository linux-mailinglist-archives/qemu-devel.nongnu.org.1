Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC7952A53
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Aug 2024 10:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seVd3-0002LH-QS; Thu, 15 Aug 2024 04:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVcr-0001Pn-4t
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVcp-0002cS-62
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723709666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wcud/RY98h9IQ5H9AMpFCRvD9OaCwdnfvMr98nTp/S8=;
 b=EeDmqdExxUCT6/2g3LI08HXkL0s81bnaOw5MvxWVirfaJgoYV7eJ6gVWVOmH5PsDTgXiQv
 Y5vKwxQV6onQhcOaCIiRvb9GSGShQUNtbyocxBBBzz82g9d3CjeKW9771MhktZrNmzErKQ
 z5QVN7eqdRXV6ASaQHtJRkL9z4S1PTM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-WjiaqU9wM2yPczRPT_Ul_Q-1; Thu, 15 Aug 2024 04:14:23 -0400
X-MC-Unique: WjiaqU9wM2yPczRPT_Ul_Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7aa56d8b14so59890766b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 01:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723709662; x=1724314462;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wcud/RY98h9IQ5H9AMpFCRvD9OaCwdnfvMr98nTp/S8=;
 b=YmiBzcnstn23ZOA2kXkvusHkbDQKI7y/K7RYbqQrzw91TdzlB1sY+81jibh+8NnlCc
 NP/Hhv16kOTucEI22OOxQ1GehxN7Ng0jOAEiLuZUlR9kTKfoDwTEIY0KEeEVVy+hw2nX
 aJORRyXUIqmv9AWsQYPm+vsSzoVN69pV6YKxTOfyTfOn3Z4hMukDVL6IoBs+RMcrQ3vQ
 BuXslMJ3Ej4Ky5b9g3DnFiBBGB7CTlDuVhXyQC7zBwGyb0YylYGs9BkVckICn6oFabsH
 RfR6Tzji64Dyc2DQrjZNCawhVSh3ddJFoEzZpLICCQY+5P3ZFnu4kayMMH3o8yjEyBSq
 yDSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTHmWMzDuUWpDuy+MmmV5njb2n2cn0P3JwKEIK9Aaae+e/ML0Qe5yDAuHqKLQbjPnLF75ZYk/RtCU12RkQrJFxBrNul8U=
X-Gm-Message-State: AOJu0Yxw+y9wGXobmDmQlGbSR0K5b9tqCYIdQTtR1CFFAYytu6p3ODjc
 DAq0kT96/JyzrfDpf4DG0pyJj95wPp9KIPTVDlLmeEJNLfMfNp/xo/HA93JHqNMbJCsOO1X5Mk6
 lYSXqqbfp03Thrc6NJVIpEZG7aC04J8btjNqZetiGkVbH1ls3ZXhX
X-Received: by 2002:a17:907:e64d:b0:a7a:b0a0:ebd2 with SMTP id
 a640c23a62f3a-a8366d5b851mr379275666b.32.1723709662359; 
 Thu, 15 Aug 2024 01:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Qu8msYjZc32W2XHDNFD1htJuB6lZowPNuYttztsMBenVinFL/ipBEqMmOs6+hif4fdNCBA==
X-Received: by 2002:a17:907:e64d:b0:a7a:b0a0:ebd2 with SMTP id
 a640c23a62f3a-a8366d5b851mr379273766b.32.1723709661877; 
 Thu, 15 Aug 2024 01:14:21 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm63399166b.137.2024.08.15.01.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 01:14:21 -0700 (PDT)
Message-ID: <1a568716-c9a8-4599-b759-fc4b76c5d1be@redhat.com>
Date: Thu, 15 Aug 2024 10:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] contrib/plugins/hotblocks: fix warning when compiling
 on 32bits host
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-5-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240814233645.944327-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/08/2024 01.36, Pierrick Bouvier wrote:
> Found on debian stable (i386).
> 
> ../contrib/plugins/hotblocks.c: In function 'vcpu_tb_trans':
> ../contrib/plugins/hotblocks.c:117:56: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    117 |     cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
>        |                                                        ^
> ../contrib/plugins/hotblocks.c:126:40: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    126 |         g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/hotblocks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 02bc5078bdd..d540f1b7f0b 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -109,9 +109,9 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>   static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>   {
>       ExecCount *cnt;
> -    uint64_t pc = qemu_plugin_tb_vaddr(tb);
> +    uintptr_t pc = qemu_plugin_tb_vaddr(tb);

qemu_plugin_tb_vaddr() return uint64_t, so this looks wrong to me, too.

  Thomas


