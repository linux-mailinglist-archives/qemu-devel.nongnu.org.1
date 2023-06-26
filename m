Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 148AF73DBE6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDivr-0005Y3-Ov; Mon, 26 Jun 2023 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qDivp-0005S4-3A
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:54:49 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qDivn-0006Xo-C7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oEGpZpa5L+G9Dl1yJSx8F7lPMo8NVTTgVmwt8EpEDMk=; b=WumN5Vj3p+weDcioBMHrEqPV5X
 qp3+C7RoT/nRcFm56n3s8ho3/JcCVZy33OeS69hrL9GbiEZlqIyvIqIPp1n4ytKrWBMPPmIrZQiRK
 wo7CDiy5A36EuVzMBb2+aRkg/EhkUDnRgclnFP9RlsjFSIaqldK8E0BdVe5rc0Vu+dJ4=;
Message-ID: <77ab0f0b-3e46-d06f-c528-a68fd697ba05@rev.ng>
Date: Mon, 26 Jun 2023 11:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 19/21] target/hexagon: import parser for idef-parser
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 bcain@quicinc.com
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com,
 Alessandro Di Federico <ale@rev.ng>, Paolo Montesel <babush@rev.ng>
References: <20221216204845.19290-1-tsimpson@quicinc.com>
 <20221216204845.19290-20-tsimpson@quicinc.com>
 <CAFEAcA8gTAYQD_a85OGPMs8KgvLRBZ0vok3QL=K3N29BnuoiHw@mail.gmail.com>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <CAFEAcA8gTAYQD_a85OGPMs8KgvLRBZ0vok3QL=K3N29BnuoiHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 6/23/23 14:50, Peter Maydell wrote:
> On Fri, 16 Dec 2022 at 20:51, Taylor Simpson <tsimpson@quicinc.com> wrote:
>> +lvalue : FAIL
>> +         {
>> +             @1.last_column = @1.last_column;
> ...we have coded an "x = x" assignment that has no
> effect. Was this supposed to be something else, or should it
> just be deleted?
Ah, thanks! This line can be deleted, I'll go ahead and submit a patch.

-- 
Anton Johansson,
rev.ng Labs Srl.


