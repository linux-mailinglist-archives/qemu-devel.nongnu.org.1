Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE87CCDB1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqTk-0006s5-Rs; Tue, 17 Oct 2023 16:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1qsqTc-0006qp-G2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:15:44 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>) id 1qsqTa-00077N-6k
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:15:39 -0400
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 8F49E6080225;
 Tue, 17 Oct 2023 22:15:35 +0200 (CEST)
Message-ID: <087e1543-1f22-4cea-b5b5-c3f9970787cd@csgraf.de>
Date: Tue, 17 Oct 2023 22:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: Enable 1G page support
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Cameron Esfahani <dirty@apple.com>,
 Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230420225258.58009-1-agraf@csgraf.de>
In-Reply-To: <20230420225258.58009-1-agraf@csgraf.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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


On 21.04.23 00:52, Alexander Graf wrote:
> Hvf on x86 only supported 2MiB large pages, but never bothered to strip
> out the 1GiB page size capability from -cpu host. With QEMU 8.0.0 this
> became a problem because OVMF started to use 1GiB pages by default.
>
> Let's just unconditionally add 1GiB page walk support to the walker.
>
> With this fix applied, I can successfully run OVMF again.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1603
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Ping. Anyone willing to pick this up? :)


Alex



