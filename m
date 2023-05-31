Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE01718E02
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TuP-0008LB-Ad; Wed, 31 May 2023 18:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4TuM-0008KD-Hi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:03:06 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4TuK-0004td-5g
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:03:06 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9700219be87so4889766b.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamhpc-com.20221208.gappssmtp.com; s=20221208; t=1685570581; x=1688162581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Im8aOBIWTtUHcfwyThVpTz4sidYrwta5mdpCqc6P3Hk=;
 b=upBkNLOOKWIqzkZ5+Odvk4OLEqcBXrAikrGFM1RGH8yTCfexSN36n4g2FnaZmiWy96
 8b0ROD8QFEwULuQJwvlK9RGatQJ4CHK7F/p5r38J6xRTKjltWFZyWg8hbK6lPmfH8JU/
 J2crf9972Dd4Oi8Ywwr5VLN35r3SyLESfGbwNMzB7KIYTh3QUOnj8UQ02YUi7MepPs5A
 GEivyBrYNcQij3qsm153ogaedYM4rlut3CkC1yPAcxSDfKaFYBil0Y+xDDZFqYPtIdk8
 H4hLLKD/BAtdF7UU75KYk/18Fur+RatMWaqmSJTrsZhMivKjDeAcb4KwZ/aV786AaJen
 Zdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685570581; x=1688162581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Im8aOBIWTtUHcfwyThVpTz4sidYrwta5mdpCqc6P3Hk=;
 b=M8hViX3q6XMj9lK7vMogljQejgMy4I4ju2T6FRRf16UbaK2EjBNa6DuW8kxVKkSKRV
 h6H1FPDKt6oDwOh5iSInaYtFTFYLfgRYYacrbEXfNciRuGUWkBDmwQZgPZt38jL1VDSB
 hAOh/pieon/2RwZ3i1LL7GVdJM/17X6MTky2O2uAGYrp9sjBv13uUzqJo9yr6c1IuLHr
 MYqYH5xUqB3eLnxzkEckFBvi/b5fGJdC/Nl/kemO7HDLf73wEejPvRgjY9Px872ZRJ60
 G69qJZo4foN+8QWZ+H2yPOr8g175gbR9AnwxxKz01AMSgBDur/qMdnqcQNeLek8O4Cbo
 ACxg==
X-Gm-Message-State: AC+VfDxjhamKxiTuRSvPktQOTn0A3Ftzs189ku3a+xsakrbMKT30AwWO
 YxqClpKpAl0DdpdZSoEAkpl2CQ==
X-Google-Smtp-Source: ACHHUZ4Rj68UsIaoQeiUMvKeUqmS2z5tmO/P/PzqBsVY33YP3XMdw2IwD31mvPtYOyp6qgzeeKQjvg==
X-Received: by 2002:a17:907:72cb:b0:974:1d8b:ca5e with SMTP id
 du11-20020a17090772cb00b009741d8bca5emr6381956ejc.14.1685570581698; 
 Wed, 31 May 2023 15:03:01 -0700 (PDT)
Received: from [192.168.178.121] (dhcp-077-251-030-138.chello.nl.
 [77.251.30.138]) by smtp.gmail.com with ESMTPSA id
 k9-20020a17090666c900b0097073f1ed84sm9619973ejp.4.2023.05.31.15.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 15:03:01 -0700 (PDT)
Message-ID: <9ddfb5ef-a096-7171-8d12-c18b32c694b1@streamhpc.com>
Date: Thu, 1 Jun 2023 00:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 3/4] pcie: Add a PCIe capability version helper
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-4-alex.williamson@redhat.com>
From: Robin Voetter <robin@streamhpc.com>
In-Reply-To: <20230526231558.1660396-4-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=robin@streamhpc.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 5/27/23 01:15, Alex Williamson wrote:
> Report the PCIe capability version for a device
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>Reviewed-by: Robin Voetter <robin@streamhpc.com>
Tested-by: Robin Voetter <robin@streamhpc.com>

Kind regards,

Robin Voetter

