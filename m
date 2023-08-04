Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB4A76FC9E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqWw-0008AR-Q7; Fri, 04 Aug 2023 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRqWv-0008AI-2z
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:51:29 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRqWt-00012o-6t
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691139083; x=1691743883; i=deller@gmx.de;
 bh=6m6khCm3irI+WCvf+b8CogoNyKjGyJ6pY5c09PKql54=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jH/9+mvk66eF47YxmGSIns5bxvSDIgvJdR9Y2nN8wFFPCCYVRqzWSkn3cSCxsfMUTaJz8e/
 Gs7t0QGV6z9pIkc7QQC4f3zHKB0yjVuPT9TE1Bmb5n0l8iAt2i4ZYJRHUeQdzM8Anh4b6bmd3
 n5YnXAuEgX8EZFljNJzPkfhbsnQfWhmPkcuAnVb/AbMtLncQm4hIaLrH1V/dGIz5U5HkOVv4y
 H/U/TwQenXYfLwzPhkCMY/g1pl98wbKb9gFRxMRGM/Qya/eHKx3CsasRWmQmHr95ZnVx204Bs
 z4dAncbWvabM2bs/BD2FLtG784vLuHbMBx/Yo+deiX8aLrm8fAdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiDX-1qCDMC1Yad-00Q9jc; Fri, 04
 Aug 2023 10:51:23 +0200
Message-ID: <70683fce-6d98-803b-178f-2db89b6203ae@gmx.de>
Date: Fri, 4 Aug 2023 10:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 07/17] linux-user: Remove last_brk
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-8-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230804014517.6361-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w8ih5zGxebAI0py7yrmHrvA0vQbJblzVG+Dq+aAvBU3Pa5+CKxO
 DvXmHlja2+/+2qOF+Nz74Vkyk7/8/ggbMTwwQEf134ZZfCApa6p9FBInATLInRZBWbOlCmu
 ajnwzWUKU1JfYaZZbD30Cr00oDoeSn2W/A8QxaK2iVvW6r+93h685r9dDwJSh7WpOmZSivj
 ns7tGCg5vV9iuMcyK7Z9w==
UI-OutboundReport: notjunk:1;M01:P0:3RQs2xQ0af4=;9B7HW/K+6ojbSa8Ne5vpDjn5tNA
 GsozAiOe4NyWFmmv807Av85uvpEkxnoIOECkHhhSBbhdnlxuGAYoTqLIeASZGf9R0h+wlI5TH
 0lUerNSBay9dtGqfR29H4dfqoiazPCTnWFDKwhdkHT4UU56w959FAn9oLQnfT3iPHUQiEXWJc
 8Xks4z96/szokbbdNyepNuol+GiDXmcPe1GVjA+fuBWA07sqE6RY+NS50W8MmqXm6eAJd3sSt
 V5BH6BUB9Bt4HAFOxL48JK5UJPfgEojGHaO3GV/BAtNSSC0zR+WSiIAELkEvclzDmai7bSbPZ
 daKtTFVL8M+6i7DdYxfTSaQ9WUIo8YTzobM18LD4KAi3nlcg4+wytmO8/CMaDFrTtFekDGh+p
 eNaaqSga9k5HvxqX7T0GQJzMgKDsPYGWCSZcNOTtvLQ0aAnsK5YO1H5X0YCvfxn3SxQD2Teh0
 Ocy0Bnb07Z2MiOUEtBlT84e+HEkghqhaBtfyrhtMQXi8ro4QU3KgP0BGDNpTJfbQQPQPwDoHB
 8P+4R0PrvnGJebPKrIC4PN9av+tG4TFwp+I974T1t8+gtQ3OiLT6jxhsULipW/dt+4HPeqmZp
 00X5wCEn2HZwJZxEfuJSBdEI2/X7uGp5sgbmIi95/QeCEcKHMiLDl66UxMoGF3piaQgPna7da
 Bzq02cavMeBmTttaRezUrLaZCC+hBFrx1htWDE73OJuEyiL4f1A9L0WdW00kuMg7Ahu/OVYEb
 FJEL8XaZ3txL1yoNmb8FMwfosW5IeCSZnUKCiJt0E0NVFA9bAMRzcsRpCJhxnbVaHbn+Ae7rl
 Z6onxqhIwqhsNiMlnkQ067kOx+WNs3ChbT/W+Zl7kag76XShcv0bmwBGWU8vROHvQNY0Q3X9a
 ZoEUWPwYLh07ryzfvzh6d4QOAgZl6yblRQZ0hvCNplEkByCXGPJRx06rpcKJ20RSa7+eagtuj
 /UQP4rTiHL2mx0+XS5XXgzpaZ4o=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/4/23 03:45, Richard Henderson wrote:
> This variable is unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


