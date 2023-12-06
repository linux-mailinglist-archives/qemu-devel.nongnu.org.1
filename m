Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1F806E22
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:37:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAqCS-0008IF-J6; Wed, 06 Dec 2023 06:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAqCN-0008Hl-G7
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:36:16 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAqCE-00056q-IT
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:36:08 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1db99cd1b2so53539366b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862561; x=1702467361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JetMu1eKmojHLKs7fkeNOqZDSgikv0xo99+ZiPlcg44=;
 b=UVpg5qkhNVhrFi/rfmQ12puK848TfCMp3ZU6iUnw3DNIP8tAejRKuHDC1pY6wt9pyG
 OMHyOjm7xDnH1jI5ey4gqyf7IxB5bRzyX5vy7GRDieL6zqTqnXHVHqdVi/9dFRZ0ZYOk
 Ga3uvIVTHnRrDC7PrDASOJyzDbK20fEYXD96TuDfzzYJ6692zheirwUlAI/fxSJNag7g
 mA+bTR7C6Fkyk2JYdtdkc8k0zT55AhCSlYN+sqb7a2zk2VMO+HbcECCbYjd8SRz4l+FZ
 jX9s+hPL70fTXRID9i5nLvkZrUWVwckENzcnSPuYCvatD4HMBbeU5Gs/1wUedQ7DWNp6
 PwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862561; x=1702467361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JetMu1eKmojHLKs7fkeNOqZDSgikv0xo99+ZiPlcg44=;
 b=hcQAICI+bLXP2ARelTKzoiGk5bIAHguipFz90b7lhtMkxIEesdtLAU2JNSA4bb3kzr
 ZxV9H/XG/gy3APL+ojzl0Q83qmsbdsSF4hJ6jcVRXzcBNiEl/HggA6+iY4ySAyLn+M4V
 idb+n6C7/kjbZ0JBBvEvhtMa2TqKSTFz8G3owAv0d48rI8Tb5tQyxEnQiljqhyrHM5oo
 0yHDsOXeJVZVd+o5423wFgmnDNeAhsBny5ucL6HRkDR++CVsRPe9gR6yq8q8FTfNK0+i
 gPK0F+PjBzMmOEbA+ubGuXdzSRa4k4Mzx1CGgR7DdGvdKWdH/XzubWUzrf0LvaiZ0e74
 TTdA==
X-Gm-Message-State: AOJu0YyzXX3F5Wwkq7PUPFoUbl6IeKThusD3bogQUNbZqGl86fx/QpkC
 yvP3fK+DESmk6HuLj0fxyJmV4w==
X-Google-Smtp-Source: AGHT+IE2nJLlFN8/VH/ykWgek03OCPSGYmOKKDlAVLBHvGSiY7jlgYGR0jSdxtVkUHHW0ojMTypaIA==
X-Received: by 2002:a17:906:103:b0:a19:4ce3:dbb3 with SMTP id
 3-20020a170906010300b00a194ce3dbb3mr411254eje.10.1701862561429; 
 Wed, 06 Dec 2023 03:36:01 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 u17-20020a170906409100b00a1dd8945d31sm468681ejj.34.2023.12.06.03.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:36:01 -0800 (PST)
Message-ID: <3536aaa0-a6c6-4db0-bf84-3218ee9e22f1@linaro.org>
Date: Wed, 6 Dec 2023 12:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] replay: introduce a central report point for sync
 errors
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Hi Alex,

On 5/12/23 21:41, Alex Bennée wrote:
> Figuring out why replay has failed is tricky at the best of times.
> Lets centralise the reporting of a replay sync error and add a little
> bit of extra information to help with debugging.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 12 ++++++++++++
>   replay/replay-char.c     |  6 ++----
>   replay/replay-internal.c |  1 +
>   replay/replay.c          |  9 +++++++++
>   4 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index 1bc8fd5086..709e2eb4cb 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -74,6 +74,7 @@ enum ReplayEvents {
>    * @cached_clock: Cached clocks values
>    * @current_icount: number of processed instructions
>    * @instruction_count: number of instructions until next event
> + * @current_event: current event index
>    * @data_kind: current event
>    * @has_unread_data: true if event not yet processed
>    * @file_offset: offset into replay log at replay snapshot
> @@ -84,6 +85,7 @@ typedef struct ReplayState {
>       int64_t cached_clock[REPLAY_CLOCK_COUNT];
>       uint64_t current_icount;
>       int instruction_count;
> +    unsigned int current_event;
>       unsigned int data_kind;
>       bool has_unread_data;
>       uint64_t file_offset;
Shouldn't this field be migrated?

