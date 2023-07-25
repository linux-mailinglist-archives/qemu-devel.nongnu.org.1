Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEC76211D
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:14:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMXz-000309-0p; Tue, 25 Jul 2023 14:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qOMXx-0002zl-P0
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:14:09 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qOMXw-0003MS-62
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:14:09 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qOMXp-0004ar-3a; Tue, 25 Jul 2023 20:14:01 +0200
Message-ID: <babdaac9-bd65-18a0-66d7-45fa30cedbbc@maciej.szmigiero.name>
Date: Tue, 25 Jul 2023 20:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
 <874jlsiejj.fsf@pond.sub.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v6 4/6] qapi: Add HvBalloonDeviceInfo sub-type to
 MemoryDeviceInfo
In-Reply-To: <874jlsiejj.fsf@pond.sub.org>
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

On 25.07.2023 10:25, Markus Armbruster wrote:
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
>> +                hi = value->u.hv_balloon.data;
>> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>> +                               MemoryDeviceInfoKind_str(value->type),
>> +                               hi->id ? hi->id : "");
>> +                if (hi->has_memaddr) {
>> +                    monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n",
>> +                                   hi->memaddr);
>> +                }
>> +                monitor_printf(mon, "  max-size: %" PRIu64 "\n", hi->max_size);
>> +                if (hi->memdev) {
>> +                    monitor_printf(mon, "  memdev: %s\n", hi->memdev);
>> +                }
>> +                break;
>>               default:
>>                   g_assert_not_reached();
>>               }
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a08b6576cac6..5ede977cf2bc 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -1265,6 +1265,29 @@
>>             }
>>   }
>>   
>> +##
>> +# @HvBalloonDeviceInfo:
>> +#
>> +# hv-balloon provided memory state information
>> +#
>> +# @id: device's ID
>> +#
>> +# @memaddr: physical address in memory, where device is mapped
>> +#
>> +# @max-size: the maximum size of memory that the device can provide
>> +#
>> +# @memdev: memory backend linked with device
>> +#
>> +# Since: TBD
> 
> I understand why you put in TBD here (aiming for a moving target is a
> hassle), but patches not marked RFC should have no known issues that
> should be fixed before merging them.

Will change TBD to 8.2 then.

>> +##
>> +{ 'struct': 'HvBalloonDeviceInfo',
>> +  'data': { '*id': 'str',
>> +            '*memaddr': 'size',
>> +            'max-size': 'size',
>> +            '*memdev': 'str'
>> +          }
>> +}
>> +
>>   ##
>>   # @MemoryDeviceInfoKind:
>>   #
>> @@ -1276,10 +1299,13 @@
>>   #
>>   # @sgx-epc: since 6.2.
>>   #
>> +# @hv-balloon: since TBD.
>> +#
>>   # Since: 2.1
>>   ##
>>   { 'enum': 'MemoryDeviceInfoKind',
>> -  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc' ] }
>> +  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
>> +            'hv-balloon' ] }
>>   
>>   ##
>>   # @PCDIMMDeviceInfoWrapper:
>> @@ -1313,6 +1339,14 @@
>>   { 'struct': 'SgxEPCDeviceInfoWrapper',
>>     'data': { 'data': 'SgxEPCDeviceInfo' } }
>>   
>> +##
>> +# @HvBalloonDeviceInfoWrapper:
>> +#
>> +# Since: TBD
>> +##
>> +{ 'struct': 'HvBalloonDeviceInfoWrapper',
>> +  'data': { 'data': 'HvBalloonDeviceInfo' } }
>> +
>>   ##
>>   # @MemoryDeviceInfo:
>>   #
>> @@ -1327,7 +1361,8 @@
>>               'nvdimm': 'PCDIMMDeviceInfoWrapper',
>>               'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>>               'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
>> -            'sgx-epc': 'SgxEPCDeviceInfoWrapper'
>> +            'sgx-epc': 'SgxEPCDeviceInfoWrapper',
>> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
>>             }
>>   }
>>   
> 
> The organization of the series feels a bit awkward.
> 
> In this patch, you define QAPI types and add a bit of code reading them,
> but the code creating them is left for later.
> 
> In the next patch, you define a QMP event, but the code sending it is
> left for later.
> 
> In the final, huge patch, you fill in the blanks.
> 
> Adding definitions before their uses can be the least awkward solution.
> But then the commit messages should point out that uses come later.
> Describing these future uses briefly may be necessary to help the reader
> understand the patch on its own.
> 
> Perhaps you can restructure the series instead.

Will make use of your suggestion in the other e-mail to refactor
it like this:
> 0. The driver with QMP stuff omitted / stubbed out
> 
> 1. Enable query-memory-devices
> 
> 2. Add HV_BALLOON_STATUS_REPORT event

Thanks,
Maciej


