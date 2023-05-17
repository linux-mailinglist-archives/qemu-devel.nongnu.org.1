Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6A706A8E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 16:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHnK-0001x4-K6; Wed, 17 May 2023 10:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eiakovlev@linux.microsoft.com>)
 id 1pzHnI-0001wq-JT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:06:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eiakovlev@linux.microsoft.com>) id 1pzHnH-0002Lx-3e
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:06:20 -0400
Received: from [192.168.0.20] (unknown [77.64.253.210])
 by linux.microsoft.com (Postfix) with ESMTPSA id 431D220F268C;
 Wed, 17 May 2023 07:06:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 431D220F268C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1684332376;
 bh=l/+4fmv3AEsxLiyPrwefDTN6hJog7rvvUpCwc7fH+bQ=;
 h=Date:To:Subject:From:From;
 b=i0i2sY2aaW8vZbiIrOjSSTVe0HE10GhsC20jNjaVMHBGmaqUw8PXrXJZDhkPk7qRD
 VXyoUKfX9aZCgO19DBbGDAxGU7YmFFI1SQh0joR5szUh9hHN46Brcahjejb8GPGk0i
 HsNlAA6ZHduEbw8ZbP5nUBxoZBA+U4WSW2wN8Qzs=
Message-ID: <81b530db-310c-ada2-5b84-0b65d434556a@linux.microsoft.com>
Date: Wed, 17 May 2023 16:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] tcg/i386: Set P_REXW in tcg_out_addi_ptr
Content-Language: en-US
From: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=eiakovlev@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -197
X-Spam_score: -19.8
X-Spam_bar: -------------------
X-Spam_report: (-19.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 FAKE_REPLY_A1=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

A bit late to the party, but still

Tested-by: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>



