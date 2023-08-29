Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA8378C54D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:28:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaylZ-0003fK-72; Tue, 29 Aug 2023 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qaylD-0003eP-Uw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:28:02 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayl2-0005lh-TE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:27:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so6117207a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693315667; x=1693920467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hdCr/xaknJMc1L+y1DfMYs+q0IfAPJxqGX0jNCojQXk=;
 b=X4NywOJrFgNOwjuz3ZYkxVcwkJV+C6witG6qysDkcHQn8Ceq4t0v+nEft6ylM0DAPv
 tERO/+d18hpG6AwqqPIa6ZK4J++ZEMkOPPoPXOPSgs5tIl6MvVzv+Lj+7RDeaAaMJbPi
 sOkabyA4WyGJoGeTL63aUiMvqoh4Q+0iM5faNF5pylooFsXIAxbHt7lpV1YBaoqC0+zL
 UFFrCFO8yCerp2HFP6ImQm9uCkpbgwI6kWeQk2bIFnz0BwksMOAPYS82o8zQ704wyOQU
 0BeZOHEEMbXfbaVJ1SF1yAdUInBlXD0oQPEELMUKWp0qcuCdLmve7m743++ff36Df3XD
 qPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315667; x=1693920467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdCr/xaknJMc1L+y1DfMYs+q0IfAPJxqGX0jNCojQXk=;
 b=L8vTFbRf4xjFLLacG02v+2fr2ythMuL08sRzTSsdV4u1VFSD4uHKgXWZBB2f7TjtVv
 Cw5wE0vZhz+1AaFi8sWcCdKJOdnrlxBrnF2fbUWk+kH9L35ml8MdWDIfgjHLOGLD03sm
 oxBL1QvKodX6dobck1zANw3fFiIONQqaGivOwly3jUVc0LXs7t/J1NSgGL9ePJePIJg7
 XPJR2yxrAFM84GHTT4Y6XGn0pWHmeNXljDpCymMxoIUiLHQk2QCSbutyJowpNoNR/abR
 txRE4qBQqzl4fHwymLigTM1/SuH9mhcjRR47tHTUHLcMRrVKoO1unlAgh9Y00b8uRI0D
 cQAg==
X-Gm-Message-State: AOJu0YzrlVxiy8Hgj08HjdnJo8Lx2WUcXwMXkwL2n5Xd7qEHfhwfiECQ
 WOQTRSldFSXufF2bD3i7neNMzPz0xKrk9JQfo5SXng==
X-Google-Smtp-Source: AGHT+IHATJl8ERWdSfIG4kO+wpHEhNyydZcucDYaq4SGCW7CXYDHcKtYR1FnT7rXm0eJDzPisqCRlV1HIsYT6XcnMmc=
X-Received: by 2002:aa7:c741:0:b0:525:73dd:4f71 with SMTP id
 c1-20020aa7c741000000b0052573dd4f71mr21510042eds.14.1693315667300; Tue, 29
 Aug 2023 06:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692964891.git.jcd@tribudubois.net>
 <d579043fbd4e4b490370783fda43fc02c8e9be75.1692964892.git.jcd@tribudubois.net>
In-Reply-To: <d579043fbd4e4b490370783fda43fc02c8e9be75.1692964892.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:27:36 +0100
Message-ID: <CAFEAcA8fnJSJ=xauxDv_GA0hHqtbt-ZfcX-g72ThiK-azRX6zQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] Refactor i.MX6UL processor code
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 25 Aug 2023 at 13:22, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> * Add Addr and size definition for most i.MX6UL devices in i.MX6UL header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>   - SAI
>   - PWM
>   - CAN
> * Add/rework few comments
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

