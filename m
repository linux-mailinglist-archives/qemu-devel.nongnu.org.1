Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43584703EE9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyfCT-0000jq-Bb; Mon, 15 May 2023 16:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyfCR-0000jY-G2
 for qemu-devel@nongnu.org; Mon, 15 May 2023 16:53:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyfCP-0000sn-0o
 for qemu-devel@nongnu.org; Mon, 15 May 2023 16:53:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64359d9c531so9918401b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684184019; x=1686776019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M5TKo8pXkTCaPYGgNf/VlZvtmdVGY9K3mZy2YMddxXM=;
 b=rdAP1NPg8Bl/7irQHpNX9Zt08TOssWfI3PuJgCz+hKLFEPiPKNutfh+Y3F6TLJjLEM
 Qk7qBBQdvBsY46ETpTp5etXFxC2MwqECLO+1hmTQbTsh93i/Hq19fEMj4Bt1i13OVNi/
 63fXCzbt05TwnQYetPospvSxqvb5Ndv97A/HU3KnR5GsZgIixVsLrcyZxkcQuIIKPSy7
 udGBRCBZIlIFRaXKa7OLOKAP2nBykHLQmkHQNDf/e3S/4uqEKAmjmjg3XiBgnybyS/SO
 a6ySf+qy3CTWRa7BLsLa4+g7WNlNyDW4tgO83VOvf00NSKFEIGq3xKJBgB8mJK0D99xj
 uD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684184019; x=1686776019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5TKo8pXkTCaPYGgNf/VlZvtmdVGY9K3mZy2YMddxXM=;
 b=b8cZt+Yf1uRcVddtXWlTCai1urTNaKXr2cQ+c55HXo4V67qp70Oe2p2lh9jZvBShH2
 JqW2A+qObJ2C1vV/cFuQW2XrOTx+LBSZSE7VFTGPM74lY/7BQMVk/ItqsHu1ljCc7PQT
 dp1WL7KQTePNjvIdlu9CxV+E7OecJSUk95yMHONepX7Iau6pq3yIuwNhgzRZ5qnwG8R0
 1riQ27QLX/prl1pLbdNB/Ycw8Q7MYgzIUqHr+k00CB0kxRegucMzukM0lOF++jOCGCw6
 f+kJne1N2syhNff8a4BvC2ya06wPpRplFtdmQmLhH9YYinbMkZlnnSCw2dZ40WsP/HXE
 AB9g==
X-Gm-Message-State: AC+VfDyAFVcmSWiHVfygNI6ytyKAVxWPQdYlKk+kZQ5unILTFC/0bzJi
 ZV6leQdViXfP0KG5fl+IgLkYp+pvdBl717NxGok=
X-Google-Smtp-Source: ACHHUZ6e5SaI2h8vDTMWedIiDByNjldz9FJeYJsojFuZS3yoUZKJY1YL26VjB9JVYqZG4bjJrDPyyA==
X-Received: by 2002:a05:6a00:139b:b0:64c:b8bd:4192 with SMTP id
 t27-20020a056a00139b00b0064cb8bd4192mr1977205pfg.6.1684184019646; 
 Mon, 15 May 2023 13:53:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9902:96ac:8d8c:4366?
 ([2602:ae:1598:4c01:9902:96ac:8d8c:4366])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a62e517000000b0064398fe3451sm12061516pff.217.2023.05.15.13.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 13:53:39 -0700 (PDT)
Message-ID: <5f7ffa1f-1c97-64f6-959b-52086b887fd5@linaro.org>
Date: Mon, 15 May 2023 13:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/21] Tests, docs, s390x and misc patches
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230515130233.418183-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230515130233.418183-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

On 5/15/23 06:02, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
> 
>    Merge tag 'or1k-pull-request-20230513' ofhttps://github.com/stffrdhrn/qemu  into staging (2023-05-13 11:23:14 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-05-15
> 
> for you to fetch changes up to 055eb1d7de455ecb6b2f5f978b2d12529e09f795:
> 
>    tests/tcg/s390x: Test EXECUTE of relative branches (2023-05-15 14:50:35 +0200)
> 
> ----------------------------------------------------------------
> * Various small test updates
> * Some small doc updates
> * Introduce replacement for -async-teardown that shows up in the QAPI
> * Make machine-qmp-cmds.c and xilinx_ethlite.c target-independent
> * Fix s390x LDER instruction
> * Fix s390x EXECUTE instruction with relative branches

This needs to be rebased after Juan's migration patches.  Something in the #include 
simplification has caused multiple build errors, e.g.

https://gitlab.com/qemu-project/qemu/-/jobs/4288929197#L2526

../migration/dirtyrate.c: In function ‘record_dirtypages’:
../migration/dirtyrate.c:68:24: error: invalid use of incomplete typedef ‘CPUState’
    68 |         dirty_pages[cpu->cpu_index].start_pages = cpu->dirty_pages;
       |                        ^~


r~

