Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951075F55D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtyV-0004iy-0y; Mon, 24 Jul 2023 07:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qNtyP-0004ih-S5
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:43:34 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qNtyN-0005V9-Ql
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:43:33 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qNtyC-00076t-EV; Mon, 24 Jul 2023 13:43:20 +0200
Message-ID: <cbe30f06-c787-7baf-01c9-573da902fa35@maciej.szmigiero.name>
Date: Mon, 24 Jul 2023 13:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 4/6] qapi: Add HvBalloonDeviceInfo sub-type to
 MemoryDeviceInfo
Content-Language: en-US, pl-PL
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <a23da090a925e98e98ccc15505345b277bcf393b.1689786474.git.maciej.szmigiero@oracle.com>
 <87zg3lmtex.fsf@pond.sub.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <87zg3lmtex.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

On 24.07.2023 13:37, Markus Armbruster wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Used by the hv-balloon driver to report its provided memory state
>> information.
>>
>> Co-developed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
>>   qapi/machine.json          | 39 ++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
>> index c3e55ef9e9cd..7b06ed35decb 100644
>> --- a/hw/core/machine-hmp-cmds.c
>> +++ b/hw/core/machine-hmp-cmds.c
>> @@ -247,6 +247,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>>       MemoryDeviceInfo *value;
>>       PCDIMMDeviceInfo *di;
>>       SgxEPCDeviceInfo *se;
>> +    HvBalloonDeviceInfo *hi;
>>   
>>       for (info = info_list; info; info = info->next) {
>>           value = info->value;
>> @@ -304,6 +305,20 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>>                   monitor_printf(mon, "  node: %" PRId64 "\n", se->node);
>>                   monitor_printf(mon, "  memdev: %s\n", se->memdev);
>>                   break;
>> +            case MEMORY_DEVICE_INFO_KIND_HV_BALLOON:
> 
> This is the only occurence of MEMORY_DEVICE_INFO_KIND_HV_BALLOON at the
> end of the series.  Where are MemoryDeviceInfo with this union tag
> created?
> 

 From patch 6:
+static void hv_balloon_md_fill_device_info(const MemoryDeviceState *md,
+                                           MemoryDeviceInfo *info)
+{
+    HvBalloonDeviceInfo *hi = g_new0(HvBalloonDeviceInfo, 1);
+    const HvBalloon *balloon = HV_BALLOON(md);
+    DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        hi->id = g_strdup(dev->id);
+    }
+
+    if (balloon->hostmem) {
+        hi->memdev = object_get_canonical_path(OBJECT(balloon->hostmem));
+        hi->memaddr = balloon->addr;
+        hi->has_memaddr = true;
+        hi->max_size = memory_region_size(balloon->mr);
+        /* TODO: expose current provided size or something else? */
+    } else {
+        hi->max_size = 0;
+    }
+
+    info->u.hv_balloon.data = hi;
+    info->type = MEMORY_DEVICE_INFO_KIND_HV_BALLOON;

                   ^ here.

Thanks,
Maciej


