Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C6791637
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7iC-00018U-BT; Mon, 04 Sep 2023 07:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qd7i2-00018E-Q1
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:25:34 -0400
Received: from smtpnm6-09.21cn.com ([182.42.152.55] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qd7hz-0001Y9-TZ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:25:34 -0400
HMM_SOURCE_IP: 192.168.139.44:22361.1616275380
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id 0A0AD1124CDAB;
 Mon,  4 Sep 2023 19:25:16 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-cd7448649-4m2gt with ESMTP id
 4761f968ddd640038416c716ef1611fd for kraxel@redhat.com; 
 Mon, 04 Sep 2023 19:25:21 CST
X-Transaction-ID: 4761f968ddd640038416c716ef1611fd
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <53c35332-cd31-4814-ae7d-19520d749420@chinatelecom.cn>
Date: Mon, 4 Sep 2023 19:25:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Subject: Re: [PATCH v1 0/2] ui/vdagent: Fix two bugs about disconnect event
 handling
Content-Language: en-US
To: kraxel@redhat.com, marcandre.lureau@redhat.com
References: <cover.1692281173.git.tugy@chinatelecom.cn>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <cover.1692281173.git.tugy@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=182.42.152.55; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Hi Gerd, what do you think of these two patches? Can they be merged into
the upstream?

On 2023/8/17 22:12, tugy@chinatelecom.cn wrote:
> From: Guoyi Tu <tugy@chinatelecom.cn>
> 
> and resource leak
> 
> Guoyi Tu (2):
>    ui/vdagent: call vdagent_disconnect() when agent connection is lost
>    ui/vdagent: Unregister input handler of mouse during finalization
> 
>   ui/vdagent.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

