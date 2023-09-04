Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99381791658
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:43:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7z6-00073n-GH; Mon, 04 Sep 2023 07:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qd7yn-0006r6-6J
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:43:00 -0400
Received: from smtpnm6-12.21cn.com ([182.42.119.59] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qd7yj-00066Z-Gv
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:42:52 -0400
HMM_SOURCE_IP: 192.168.139.44:18680.444926620
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id CC59A110001B3;
 Mon,  4 Sep 2023 19:36:10 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-cd7448649-4m2gt with ESMTP id
 7acf7d5e455f451cb773d400659754ad for marcandre.lureau@gmail.com; 
 Mon, 04 Sep 2023 19:36:11 CST
X-Transaction-ID: 7acf7d5e455f451cb773d400659754ad
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <36796816-e55a-4aec-b3b6-c24455d07c15@chinatelecom.cn>
Date: Mon, 4 Sep 2023 19:36:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, kraxel@redhat.com, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn
Subject: Re: [PATCH v1 0/2] ui/vdagent: Fix two bugs about disconnect event
 handling
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRTWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@gmail.com>
References: <cover.1692281173.git.tugy@chinatelecom.cn>
 <53c35332-cd31-4814-ae7d-19520d749420@chinatelecom.cn>
 <CAJ+F1C+7JQEfiT8C7wHYnDZXD_6LB13+_CeYAeFB+4kShb2gkA@mail.gmail.com>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <CAJ+F1C+7JQEfiT8C7wHYnDZXD_6LB13+_CeYAeFB+4kShb2gkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.119.59; envelope-from=tugy@chinatelecom.cn;
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

On 2023/9/4 19:28, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Sep 4, 2023 at 3:26 PM Guoyi Tu <tugy@chinatelecom.cn> wrote:
>>
>> Hi Gerd, what do you think of these two patches? Can they be merged into
>> the upstream?
> 
> I'll queue them.
> 
> thanks
> 
> 
> 
I'm glad they can be merged. Thank you.

