Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C57BD4A7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpl2N-0008OP-3I; Mon, 09 Oct 2023 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1qpl2H-0008NJ-5u
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:50:41 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1qpl2F-00011Z-8b
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:Subject:From:To:In-Reply-To:MIME-Version:Date:Message-ID:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fGNcOEzLzBukw6eklI7rlDFFL/jqNu1yYYn34LYcM1w=; b=rOYcDqBvtV+cWGLoQhykq8XzMD
 RUHIK5+PPQMC1ZgF0lThSRispbPfNiiTSpdV3jH79TuiWIAFZnI96vkiDtx3aqsLk2OMRoWS/nzY8
 rjUm6YPTnmTKsPdO1ZUHDgdfFS6lDUnDnwJlKchGSKq5trRRlbaRxQTul6GQMT+K+tHaF29m7fLtV
 nG2VuHynFOQUsosgcM18jC5Y6LUnI9FxwDI3/IP9AaA9OiRD3zM1g3tJQgSTZ95KePe/fC67sfXMo
 4cfd/DKny7Gv6ANgu7s3HemTJY0+jl6E39a/pBD15heGuRR06J3iCguX15pdSAf6YAIVrVDUwiIr0
 fSB9RFig==;
Received: from [167.98.27.226] (helo=[172.16.102.186])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1qpkL6-002DzL-Sl; Mon, 09 Oct 2023 08:06:04 +0100
Message-ID: <c4700bce-ea54-423b-b9f0-e6e47a4ab076@codethink.co.uk>
Date: Mon, 9 Oct 2023 08:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
 Dickon Hood <dickon.hood@codethink.co.uk>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 00/44] Raspberry Pi 4B machine
Organization: Codethink Limited.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi, is there an git tree with this series or a newer one available
please?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

