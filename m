Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C208971FD74
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q50uq-0002Aq-FW; Fri, 02 Jun 2023 05:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q50uh-0002AW-Ez
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:17:39 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q50uf-0007K3-Kh
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:17:39 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53f158ecfe1so1065849a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685697454; x=1688289454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0l3qt2a6ZeVivg6JkO+UBjMLBDcdJgfWktJuFttkE/w=;
 b=pp3lQzzopS9mW2PiCk8HodtA4vJnvuyK8ursae3ek5Zg4liIjohnbhk3SKIv1hPiWK
 zN25uAa9HL/TtO+soq4a7fhCseHnrMugPQEPeXe2xL+sEOmDNJvs95tsxH7Mrk9qHEpq
 DYdCU7AUPoeYyZphwux44p3krUPfQiTasRx/0vL0V/jcUka3wrIW+0x/gZ2uCej6pEL3
 D30kibDtvYZ5r8Iv3WSoPQio/u5KX12EQn5NcnfI1KwqehAjkczYch5PAkLoaet2kekB
 I98FxfJ6peDTdPoh2mjCcgm/RUjWnO9h+WALZBOInqdWTzBQrrQwfi/nv1mw5sVgxKLC
 UkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685697454; x=1688289454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0l3qt2a6ZeVivg6JkO+UBjMLBDcdJgfWktJuFttkE/w=;
 b=d53eHAyvUPqBusbDxMJ3aroCo37Kq64gwNoz60S9WlX8siP/YXhOY8Kfnn9HQpLnwS
 U2PGc7mBeEzS09rCyCGr2u5Puv6jZo9FlbXm/1p46eGW8ogIyWz9FF9HfEyI9uaEVdnd
 lZ2AKZPgFNNduIL/4oM91QFosHaLHM4BBv3iSUpCtr8jL99m6DDjscnZQnzVSB7AD2cN
 Y4vGlKXco4widkvNbgbk/sT37wpkABAbr2kO6rPH85AeP3aSbc4r64c6xGR6uTPtDafq
 0o/yxBf+MPTFaIZGBKEoCJxe6s+eXTJ/XBeVf4SWyNbMLM1qx8cLdeavG2d2qTwVUboL
 81HA==
X-Gm-Message-State: AC+VfDwNIgkCihwN8cWAa+vkCLnPAY74lPm2xB8OiOtwgjtxiGPKbOmx
 dbcoPw29zvt3We8mflrAEpk8ag==
X-Google-Smtp-Source: ACHHUZ5cm1d74gl4MUTZRdbFcdO+B2KijB/yKoyeNyAjwF05zIw5hyQimfc4DP3maAbkO47WJAZLCQ==
X-Received: by 2002:a17:902:ab86:b0:1af:d9d2:a234 with SMTP id
 f6-20020a170902ab8600b001afd9d2a234mr1089419plr.3.1685697454466; 
 Fri, 02 Jun 2023 02:17:34 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:a70d:ae79:598f:409b?
 ([2602:ae:1598:4c01:a70d:ae79:598f:409b])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a1709027fc500b001a183ade911sm878958plb.56.2023.06.02.02.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 02:17:33 -0700 (PDT)
Message-ID: <78b46f14-f07e-a127-7da7-322c71e74ef5@linaro.org>
Date: Fri, 2 Jun 2023 02:17:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/6] Migration 20230601 patches
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230601234426.29984-1-quintela@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230601234426.29984-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 16:44, Juan Quintela wrote:
> The following changes since commit 9eb400cdd7b0940bd696aa01462dd53004ae04e9:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu  into staging (2023-06-01 11:47:58 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/migration-20230601-pull-request
> 
> for you to fetch changes up to 3a8b81f2e6393828589699bb0b8ef557b9ae5937:
> 
>    migration: stop tracking ram writes when cancelling background migration (2023-06-02 01:03:19 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request (20230601)
> 
> Hi
> 
> In this series:
> - improve background migration (fiona)
> - improve vmstate failure states (vladimir)
> - dropped all the RDMA cleanups
> 
> Please, apply.
> 
> ----------------------------------------------------------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


