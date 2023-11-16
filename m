Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D817EDD0D
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:43:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Xxp-0001Ek-Qg; Thu, 16 Nov 2023 03:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Xxn-0001Ec-Fy
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:43:03 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Xxl-0000Aw-NM
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:43:03 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso77554966b.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700124180; x=1700728980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CLog3Affyf9GR2XmDZ3VQ4VLvH9V9LobH2MtNEc9ogc=;
 b=E3JIiPGCCnLUG1U6mrctXQYx4EizPvl7Zi+dpqGGxlTc1L8y0YPW/YbLpm/ICzucIt
 zB9vYbpGfRVkS4fOjksffuj2Dm7MtiSq1UaaiL8o+SbN4Dt8d0u+4EopAMTpzwpIy5by
 hf1Eliowmv1+88G+z2MpIfMrr8VvgqzWrzeVD5ZBZ6OyMVlaqtILW/3vSsn3obenh5zn
 MNKiaGVILYCnRm1uxNeZAn+QlPa24eqPqxrVZR+W0WoGIzsAE8RRfB3vzMKRZ8GR914w
 BkWutrTlwtH3rMMDApf+JibsaUyDI33fdLlwWLDa8SwMydSyuyNozTPsG3KefJUhQPD1
 Sr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700124180; x=1700728980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CLog3Affyf9GR2XmDZ3VQ4VLvH9V9LobH2MtNEc9ogc=;
 b=JIGlxctW3eLRQ/iXkgEuv93pf1elUm+8qxS2wOyQjzrDLh+oJgjI7nd0ih7KWB3jC+
 P9UBtXCsi1YCjIojVA6PljqLYflaxB6uNe12EKZlegDIpjw4JzCsisGYusTNplD0eWy3
 5g1ISaIciSsEQegswllzj0vnfl53ho4SEnPzdKvl/2DBCw6yVn5Y5OoaUosCFaW+rxdo
 h7lwJQgNCvr+vJCFdIv+YOtLu4KF7gK88efcUnfeNdErrXSg096bBOHiMD5mCmZcUd3h
 etJD/1rb8N58m1j/V1mycWHUI7rgwUSX+4Ipxc83PUgEGFF9y5akd3wFwwKIwAi8g8Hw
 4KQg==
X-Gm-Message-State: AOJu0Yw2EfFIbqfziOrBOG0vj5ji+dcilzLiPQf/fJnibGgEu9FErTQO
 3tp2fA3NmG0SZA8o5eS8MLFbxA==
X-Google-Smtp-Source: AGHT+IGNMrJOPVHf9t75KNrGF3QDKQ6f46HeCUUi0hLjtzEOcYJfJGzwkpzWuDLgnsDIncOtlpnzpA==
X-Received: by 2002:a17:906:55a:b0:9c5:c9a2:9164 with SMTP id
 k26-20020a170906055a00b009c5c9a29164mr10463147eja.32.1700124179753; 
 Thu, 16 Nov 2023 00:42:59 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b009eff65e6942sm3258127ejc.197.2023.11.16.00.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 00:42:59 -0800 (PST)
Message-ID: <688bc783-e56f-4e24-95f6-a69aa4bc8863@linaro.org>
Date: Thu, 16 Nov 2023 09:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R_=C3=BC_melin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
 <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
 <47h4g.6wu5d10yw748@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <47h4g.6wu5d10yw748@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/11/23 08:33, Manos Pitsidianakis wrote:
> On Thu, 16 Nov 2023 09:32, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>>> ---
>>>
>>> Notes:
>>>      Requires patch 
>>> <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
>>
>> This is the 'Based-on: ' tag I guess.
> 
> There is
> 
>   prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4

$ git show 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
fatal: bad object 484ec9f7f6109c10d4be0484fe8e3c2550c415f4

In which tree can we find this commit? Better to use the msg-id,
so tools cat fetch prerequisite.

I guess the 'patches' tool understand 'Based-on'. Or was it 'patchew'?

> At the end of the patch, added by git-format-patch. Is it best practice 
> to include it in the commit message too?

I don't use git-format-patch directly anymore, but via git-publish.

Ideally we'd teach git-publish to record/publish email msg-ids and b4
to consume them...

Maybe worth suggesting as feature request, similarly to
https://github.com/stefanha/git-publish/issues/84 with the 'Supersedes:'
tag?

Phil.

