Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C74AF7AC318
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 17:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk4MA-0000X4-Qw; Sat, 23 Sep 2023 11:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qk4M1-0000WH-Fz; Sat, 23 Sep 2023 11:15:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qk4Ly-0005Ba-Px; Sat, 23 Sep 2023 11:15:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 259E6247E5;
 Sat, 23 Sep 2023 18:15:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 41F5C2A32D;
 Sat, 23 Sep 2023 18:15:18 +0300 (MSK)
Message-ID: <1054981c-e8ae-c676-3b04-eeb030e11f65@tls.msk.ru>
Date: Sat, 23 Sep 2023 18:15:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-8.1] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230725113632.2386874-1-peter.maydell@linaro.org>
 <CAFEAcA-DXnmtfKYrOjrSRp=rjdV-Owqm+b0=oB6y-=H=VP9fLg@mail.gmail.com>
 <CAFEAcA8YxuRGp5sfXauWfiTsOE7H6hkbRKp1Pp0ampxsct5hQg@mail.gmail.com>
 <15dad0a8-e31f-3387-4ade-45d4a9b8a6c4@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <15dad0a8-e31f-3387-4ade-45d4a9b8a6c4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

22.09.2023 18:05, Thomas Huth wrote:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Maybe this could go via qemu-trivial?
> 
> On 12/09/2023 16.08, Peter Maydell wrote:
>> Ping^2 for review/pickup by the rdma folks, please?
> 
> Is anybody still using this subsystem? ... if not, then it's maybe time to set this on the deprecation list? ... just my 0.02 €.

I applied this to my trivial-patches tree for now.

There were several security issues in this area, I think
one of them is still open with a patch posted to the list
but no one were able to review it because the code is rather
scary (iirc it was Phil who tried to review it but failed).

Here's what I have in debian for quite some time:

  # pvrdma is an extension/optimisation for vmxnet3 vmware virtual network
  # adapter. This piece of code seems to be buggy and poorly maintained,
  # resulting in numerous security issues which comes unfixed for long time.
  # This device isn't native for qemu.  # Just disable it for now.
  common_configure_opts += --disable-pvrdma

So yes, it smells like deprecating it is a way to go.

FWIW.

/mjt

>> On Tue, 29 Aug 2023 at 16:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> On Tue, 25 Jul 2023 at 12:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> In query_port() we pass the address of a local pvrdma_port_attr
>>>> struct to the rdma_query_backend_port() function.  Unfortunately,
>>>> rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
>>>> and the two are not the same length.
>>>>
>>>> Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
>>>> long, and ibv_port_attr is 52 bytes, because it has a few extra
>>>> fields at the end.
>>>>
>>>> Fortunately, all we do with the attrs struct after the call is to
>>>> read a few specific fields out of it which are all at the same
>>>> offsets in both structs, so we can simply make the local variable the
>>>> correct type.  This also lets us drop the cast (which should have
>>>> been a bit of a warning flag that we were doing something wrong
>>>> here).
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>> I don't know anything about the rdma code so this fix is based
>>>> purely on looking at the code, and is untested beyond just
>>>> make check/make check-avocado.
>>>> ---
>>>>   hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
>>>> index c6ed0259821..d31c1875938 100644
>>>> --- a/hw/rdma/vmw/pvrdma_cmd.c
>>>> +++ b/hw/rdma/vmw/pvrdma_cmd.c
>>>> @@ -129,14 +129,13 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>>>>   {
>>>>       struct pvrdma_cmd_query_port *cmd = &req->query_port;
>>>>       struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
>>>> -    struct pvrdma_port_attr attrs = {};
>>>> +    struct ibv_port_attr attrs = {};
>>>>
>>>>       if (cmd->port_num > MAX_PORTS) {
>>>>           return -EINVAL;
>>>>       }
>>>>
>>>> -    if (rdma_backend_query_port(&dev->backend_dev,
>>>> -                                (struct ibv_port_attr *)&attrs)) {
>>>> +    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
>>>>           return -ENOMEM;
>>>>       }
>>>
>>> Ping for review/testing by the rdma folks, please ?
>>> Whose tree should this patch go through?
>>
> 
> 


