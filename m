Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F0743BC7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:19:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFD5P-0003X8-7c; Fri, 30 Jun 2023 08:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFD5L-0003Mn-8g; Fri, 30 Jun 2023 08:18:47 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFD5J-00045q-8W; Fri, 30 Jun 2023 08:18:46 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso29095581fa.0; 
 Fri, 30 Jun 2023 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688127522; x=1690719522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOgcaud44g2PDp5PIg+Kl75LDD1ihbe+61gMgUnevxo=;
 b=oFeY2q5FSe3170K/ly0hyet1Lanuf1lE5DAnTAcLvrFrQOqVwlUNoQrn3bsHiXisIu
 MaKd9On3xQ+tLOR5bSoR6q407uyq0260Cv4viKBb+YuBI8cGGXezJPSDqszTcxi71pR5
 VsJEEx06JfbvzoCbBZ7gyracD35yj5tg7yNZcSuyqnr6poE83OGwLm+p0dDNOHZIg9uj
 wZNyBxrUziwV55T6AkYzH81gV2/9nPHTIWhtNxXDC4cRmaFeCuDa7somk/wIVpyVJfO8
 OVGaN20Inqq2p4Kd3wtW2VV8ehefvD5VtqvPaxAME89n2FS015gaaiu5tNw23YM/pk0l
 bS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688127522; x=1690719522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOgcaud44g2PDp5PIg+Kl75LDD1ihbe+61gMgUnevxo=;
 b=De/HXmo8n1ioF0++bJrDBuTC4yQggf0uLD10HDLppCzsb+rYR9jVHSxfwq5HncS11U
 X7xmKFZ16FvkKc/k4N/xDVwBjfsN6YkGDwC47y4xok+kkeO4kYUjHzaVnv43TquyoU+q
 ECaMAbkinsS8hPjC+PsrB6ceV2jEQXIUBlx3c+GafKYy7fyIlANV+ow4mk28aZ5A795l
 rcklitsMvQAonc8hcTT5L0VjrHtRiZNNARFTqcNm4+u0SVShzS19pGRLgv5PU0Smd+gp
 VFiwX8NK5Fscu6+bWyhr2AGrFL5p9Y3jElkuyTMHNsFUuDnHxXIUa+nIEDe2U7S2e6uA
 787g==
X-Gm-Message-State: ABy/qLaxID+ZY2QN02M84zGLlRTPpSagwvz5tNjZHUVSD0d5tu/zyYwa
 ez3+5JYKgfcS05E/kv0DYtS0nO3BGhH0LE5IT1A=
X-Google-Smtp-Source: APBJJlEt2bzrjS+GZThCA72y+4qNE/IzNOTMF7MwQnKNGgveMyrjMN+bm0yI+n6vpvDB2ZnatZ7HZyurgc1nBZftV6s=
X-Received: by 2002:a2e:97d1:0:b0:2b6:b2ff:509c with SMTP id
 m17-20020a2e97d1000000b002b6b2ff509cmr2007575ljj.8.1688127522017; Fri, 30 Jun
 2023 05:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688112025.git.yin31149@gmail.com>
 <b31f0bce96ad1b66fabeace182cddb41fede9683.1688112025.git.yin31149@gmail.com>
 <23c90163-657e-3d4b-0c74-437650a3e282@linaro.org>
In-Reply-To: <23c90163-657e-3d4b-0c74-437650a3e282@linaro.org>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Fri, 30 Jun 2023 20:18:29 +0800
Message-ID: <CAKrof1M8LRoMy4GgJubNakh1=Nob98ba3Zpp_8ojysKqXGhAEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: order vdpa_feature_bits array
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org, 18801353760@163.com, 
 QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/6/30 18:20, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/6/23 10:54, Hawkins Jiawei wrote:
>> This patch reorganizes the vdpa_feature_bits array
>> in ascending order based on its value to avoid future duplicates.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v2:
>>    - resolve conflicts with the master branch
>>
>> v1:
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01585.html
>>
>>   net/vhost-vdpa.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 0479988a79..db7f1241af 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -50,15 +50,12 @@ typedef struct VhostVDPAState {
>>       bool started;
>>   } VhostVDPAState;
>> +/* The array is sorted in ascending order based on its value */
>
> Alphabetically would have been simpler IMO, anyhow:

Yes, it seems that rearranging the array in alphabetical order could
improve the maintainability of the code.

I will sort the features alphabetically, excluding
VHOST_INVALID_FEATURE_BIT, according to your suggestion.

Thanks!

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

