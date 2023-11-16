Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D65957EDD23
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:52:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Y66-0005sj-HR; Thu, 16 Nov 2023 03:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3Y64-0005sW-FO
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:51:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3Y5x-0003KL-SC
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:51:36 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so3820485e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700124688; x=1700729488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ul9OY5KcovI6nas8cU/VJHEZObj1OuZYlFOsbmLp7gY=;
 b=hNNCVNPfC3c16u9NfR/Vr/aTTvR3rIpLHtO8pgCt8n3pSWpkA3pwYe/qdggrr1D09R
 p2wLyyNoh8XyaN1wDTvyVXLQUtLxAGud6G/aUZNbRQ8McQeIfzkDyyMnaSLZvko6pZDg
 sX/35d7Wv5BbTBZAuLgRDyBRyxc2/R29A/lDCJN2lpQzItVVQLraFfuqp4vRoc5XbzZs
 SVnQ79PsYl7z59yvyaK+BxFAbD1GncuFn4j7+TEpTehLpFdlYC+wlXcIA1ykY21f/IFr
 g9nuY6s8bNws9BWV/jyPdk6Be1VWK+tyolNOgN8+lGAtxNR+F6WIDbxJQ2GgJGzc1QKj
 mxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700124688; x=1700729488;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ul9OY5KcovI6nas8cU/VJHEZObj1OuZYlFOsbmLp7gY=;
 b=gjbcHO5VdguHVHvl8uNmS36ZOc1e9JeJmY/3zY4yd1pYdoJKyGB0mGDJ+H2QcmHOx2
 K9cbqiYGpvzxkok1CWv63zosUFBvS1ZSysfutYowuqJFba8YorNv7i8Km7yKgIoBDXUR
 gEDvyqkiWLbvbU/C7oK/AZCWclEVz1dFeb7RQJQD4Rj6JoWTgWSXHppbcm/xr7WbbjIC
 JLhkKDXu1vSTRL6akZ4Nxl95o2MtteFBlacMMuxGlutIGjNsI8kQ5k0vMxveDsxIRKq5
 j/aohCMSgTcsHJ+QBevwjy6wDsCvOhYnd/YhGaxK7YFcjH5Z7Kn5+vSTHg9jHANopmzZ
 32rQ==
X-Gm-Message-State: AOJu0YwtJKoTlNPeHKvMD0IbyOCF1fhqx+WnDBix1S6+L083GIcEETaM
 x4Yf90HVlLrY8tnZDF/tvIUUNg==
X-Google-Smtp-Source: AGHT+IFmJDDBg3MuPte5rUrW5jh8sQXTFwiaRVtCnTtvWnIX90JF8+8Z5XHqskqNDCJwvR56LIBPnQ==
X-Received: by 2002:a05:600c:35cb:b0:409:79cb:1df6 with SMTP id
 r11-20020a05600c35cb00b0040979cb1df6mr13238410wmq.14.1700124687986; 
 Thu, 16 Nov 2023 00:51:27 -0800 (PST)
Received: from meli.delivery (adsl-149.37.6.3.tellas.gr. [37.6.3.149])
 by smtp.gmail.com with ESMTPSA id
 v2-20020adfa1c2000000b0032fc5f5abafsm12915468wrv.96.2023.11.16.00.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 00:51:27 -0800 (PST)
Date: Thu, 16 Nov 2023 10:48:13 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
User-Agent: meli 0.8.2
References: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
 <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
 <47h4g.6wu5d10yw748@linaro.org>
 <688bc783-e56f-4e24-95f6-a69aa4bc8863@linaro.org>
In-Reply-To: <688bc783-e56f-4e24-95f6-a69aa4bc8863@linaro.org>
Message-ID: <47klp.p79qnee6q9fx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

On Thu, 16 Nov 2023 10:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>On 16/11/23 08:33, Manos Pitsidianakis wrote:
>> On Thu, 16 Nov 2023 09:32, Philippe Mathieu-Daudé <philmd@linaro.org> 
>> wrote:
>>>> ---
>>>>
>>>> Notes:
>>>>      Requires patch 
>>>> <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
>>>
>>> This is the 'Based-on: ' tag I guess.
>> 
>> There is
>> 
>>   prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>
>$ git show 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>fatal: bad object 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>
>In which tree can we find this commit? Better to use the msg-id,
>so tools cat fetch prerequisite.
>
>I guess the 'patches' tool understand 'Based-on'. Or was it 'patchew'?

It's not a commit SHA, that's why. It's a sha produced by git-patch-id 
--stable. It hashes the diffs of the plain-text patch.

https://git-scm.com/docs/git-patch-id

Yes, whatever works with current tools is best!

Manos

