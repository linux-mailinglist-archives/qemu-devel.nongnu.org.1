Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C172E1D4
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:40:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90VO-0005nx-My; Tue, 13 Jun 2023 05:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90VG-0005le-6Y
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:55 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90V6-0005d5-Jr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:53 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977d55ac17bso956174766b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649183; x=1689241183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NnrkfrminigaNKM7E3gR4tjgM3utFGWexpe+tZUxR6k=;
 b=BPfsbIkLs67uSwMfdIVA1p1zq0WADSdq371QIMr+iFypZMclJQYaQ/00mKq1yPvP6l
 pvmZ6XGe3BC/lI/BMRfwQ09FfqOfMLyGvXg0YaxXb6fFETwGwWTwNc4G94VdqYz8sUIK
 hCyQUxoIMvtDV+v0C7G8COdweHBmAzoZzDq8AYK+qC/276mBqWFPaxgIwitY33D9+fMT
 WxdV9kIVsIrNi81Om3pKduDPQV9vBYGJ9z8gfQr+gsnoJjaQL05RV3gQ+T+c1CUn7ZZ5
 +2PEcllByVYKeiZ4f9383FUSVUYL+ivqt/v7uo/OyPMuleZte1cW9r7iWvdLa/fC3XsT
 A/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649183; x=1689241183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NnrkfrminigaNKM7E3gR4tjgM3utFGWexpe+tZUxR6k=;
 b=gNU1RtZCH6gph1hKcd1RM4Pk2WsQ0lG/T+STAtEKtMYYThK7qwPO0tKkoTzf5t7FML
 85PIOExzuCQAUZgtZFHyJ389ANHE52QfEGeTO3bslvO2k+jOFY0xGpAWW9xjChzgTBDZ
 j/WqiPdFaajEhkqdzLL3gOO+id/VYysQnkEo+EMX2Gy03zycWRsmtlmvbUcmeCL/E8XD
 fn9P6jLInCAng9KlsO91Ue1L+4uiV7CDbYuyYfKsmO27YnN+RUAVUuFVPfTTLjUTcnHB
 yLnGMNdohKQFNQWUrho5tmxiCYixGpPOdDdmiHBRrh4wti2pcRr2cOXXUoTn/LsHH5hl
 xPRw==
X-Gm-Message-State: AC+VfDzFV0LbUFea1V/zUiYZabdPB1J+06ZdwPRYEwMkiOLkX1eXonRg
 4MSqGmBo/sRDuuBHtIQF4S5HjXz/T1vYP4d1RxkG+w==
X-Google-Smtp-Source: ACHHUZ4Pn0TOoTixQm4NDaBtehAH1yNGnXXHgm24Pd1daXRnjlD3qGNqXsqiUKZ7n/ezdraNcol7rA==
X-Received: by 2002:a2e:a165:0:b0:2ae:e214:482f with SMTP id
 u5-20020a2ea165000000b002aee214482fmr4235888ljl.52.1686648727615; 
 Tue, 13 Jun 2023 02:32:07 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a50fc0d000000b0050bc6d0e880sm6115842edr.61.2023.06.13.02.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:32:07 -0700 (PDT)
Message-ID: <c664a85d-393c-0190-9a57-8ee9bb81cf35@linaro.org>
Date: Tue, 13 Jun 2023 11:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/2] Export struct ISAParallelState
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230612081238.1742-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230612081238.1742-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/6/23 10:12, Bernhard Beschow wrote:
> This series incorporates rebased versions of the ISAParallelState patches of
> [1] as requested by Mark.

> Bernhard Beschow (2):
>    hw/char/parallel: Export struct ParallelState
>    hw/char/parallel-isa: Export struct ISAParallelState

Thanks, queued (updating MAINTAINERS in patch 2).


