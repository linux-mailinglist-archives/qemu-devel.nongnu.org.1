Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 568637D0317
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZUH-0003rW-Pj; Thu, 19 Oct 2023 16:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtZUF-0003pY-DV; Thu, 19 Oct 2023 16:19:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qtZUD-0007ug-Gj; Thu, 19 Oct 2023 16:19:19 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKHOWl026681; Thu, 19 Oct 2023 20:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=C20H7oznJfrdH63BWbCnKSXAhVd+lsYlGu2KjVqvlyo=;
 b=iyQZF//oi/WVbG4aAYaKPaBuF0lYCK1ubRD/NiUwylcjZcEuOfv3xuUGUS9spYSXWinz
 N6jxhNnFdzx8ufTp9gSylfpJNb4Td3ihJ9v2a3CUV+7LDreTjU9idB8X+B5kaVeE8oo3
 CHw28cUUDofTtEPVbPGf9CBJepq3El2UUBM1M0F+DKpw/J20shQU+CZ35WPj7sIWrygN
 hHCnvCWd3XFXpyK7PncnZcj1bFa567kEPLyvHsdFkLODrdrqCOoNy1TeL9frY9IWdr7K
 csuZIidnTZPuKkO0WEinPD2+ScjsAtYrsA0i7JIUer2cLOcpQzCGNP39Pcnzn0ao2Tu0 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tubc201vc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:18:56 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKHcGm027223;
 Thu, 19 Oct 2023 20:18:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tubc201uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:18:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JJWES6020073; Thu, 19 Oct 2023 20:18:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6anka1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 20:18:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JKIqk814287432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:18:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F69A58058;
 Thu, 19 Oct 2023 20:18:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E9F958057;
 Thu, 19 Oct 2023 20:18:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 19 Oct 2023 20:18:50 +0000 (GMT)
Message-ID: <c792bebe-5a7e-79aa-f816-770019db61dd@linux.ibm.com>
Date: Thu, 19 Oct 2023 16:18:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/13] migration: Use vmstate_register_any()
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Corey Minyard <minyard@acm.org>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Halil Pasic
 <pasic@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-3-quintela@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231019190831.20363-3-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N8ghZM7J58t9qvSqYdRxEV0Igs9agGAR
X-Proofpoint-ORIG-GUID: kg-rk69zOA84OJwxOatLol0cZonNnkl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=846
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 10/19/23 15:08, Juan Quintela wrote:
> This are the easiest cases, where we were already using
> VMSTATE_INSTANCE_ID_ANY.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   backends/dbus-vmstate.c     | 3 +--
>   backends/tpm/tpm_emulator.c | 3 +--
>   hw/i2c/core.c               | 2 +-
>   hw/input/adb.c              | 2 +-
>   hw/input/ads7846.c          | 2 +-
>   hw/input/stellaris_input.c  | 3 +--
>   hw/net/eepro100.c           | 3 +--
>   hw/pci/pci.c                | 2 +-
>   hw/ppc/spapr_nvdimm.c       | 3 +--
>   hw/timer/arm_timer.c        | 2 +-
>   hw/virtio/virtio-mem.c      | 4 ++--
>   11 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
> index 57369ec0f2..a9d8cb0acd 100644
> --- a/backends/dbus-vmstate.c
> +++ b/backends/dbus-vmstate.c
> @@ -426,8 +426,7 @@ dbus_vmstate_complete(UserCreatable *uc, Error **errp)
>           return;
>       }
>
> -    if (vmstate_register(VMSTATE_IF(self), VMSTATE_INSTANCE_ID_ANY,
> -                         &dbus_vmstate, self) < 0) {
> +    if (vmstate_register_any(VMSTATE_IF(self), &dbus_vmstate, self) < 0) {
>           error_setg(errp, "Failed to register vmstate");
>       }
>   }
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 402a2d6312..8920b75251 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -978,8 +978,7 @@ static void tpm_emulator_inst_init(Object *obj)
>           qemu_add_vm_change_state_handler(tpm_emulator_vm_state_change,
>                                            tpm_emu);
>
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
> -                     &vmstate_tpm_emulator, obj);
> +    vmstate_register_any(NULL, &vmstate_tpm_emulator, obj);
>   }
>
>   /*
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index bed594fe59..879a1d45cb 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -64,7 +64,7 @@ I2CBus *i2c_init_bus(DeviceState *parent, const char *name)
>       bus = I2C_BUS(qbus_new(TYPE_I2C_BUS, parent, name));
>       QLIST_INIT(&bus->current_devs);
>       QSIMPLEQ_INIT(&bus->pending_masters);
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_i2c_bus, bus);
> +    vmstate_register_any(NULL, &vmstate_i2c_bus, bus);
>       return bus;
>   }
>
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index 214ae6f42b..8aed0da2cd 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -247,7 +247,7 @@ static void adb_bus_realize(BusState *qbus, Error **errp)
>       adb_bus->autopoll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, adb_autopoll,
>                                              adb_bus);
>
> -    vmstate_register(NULL, -1, &vmstate_adb_bus, adb_bus);
> +    vmstate_register_any(NULL, &vmstate_adb_bus, adb_bus);
>   }
>
>   static void adb_bus_unrealize(BusState *qbus)
> diff --git a/hw/input/ads7846.c b/hw/input/ads7846.c
> index dc0998ac79..91116c6bdb 100644
> --- a/hw/input/ads7846.c
> +++ b/hw/input/ads7846.c
> @@ -158,7 +158,7 @@ static void ads7846_realize(SSIPeripheral *d, Error **errp)
>
>       ads7846_int_update(s);
>
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_ads7846, s);
> +    vmstate_register_any(NULL, &vmstate_ads7846, s);
>   }
>
>   static void ads7846_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
> index e6ee5e11f1..a58721c8cd 100644
> --- a/hw/input/stellaris_input.c
> +++ b/hw/input/stellaris_input.c
> @@ -88,6 +88,5 @@ void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode)
>       }
>       s->num_buttons = n;
>       qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
> -                     &vmstate_stellaris_gamepad, s);
> +    vmstate_register_any(NULL, &vmstate_stellaris_gamepad, s);
>   }
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index dc07984ae9..94ce9e18ff 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -1883,8 +1883,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
>
>       s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
>       s->vmstate->name = qemu_get_queue(s->nic)->model;
> -    vmstate_register(VMSTATE_IF(&pci_dev->qdev), VMSTATE_INSTANCE_ID_ANY,
> -                     s->vmstate, s);
> +    vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
>   }
>
>   static void eepro100_instance_init(Object *obj)
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b0d21bf43a..294c3c38ea 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -147,7 +147,7 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>       bus->machine_done.notify = pcibus_machine_done;
>       qemu_add_machine_init_done_notifier(&bus->machine_done);
>
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_pcibus, bus);
> +    vmstate_register_any(NULL, &vmstate_pcibus, bus);
>   }
>
>   static void pcie_bus_realize(BusState *qbus, Error **errp)
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index b2f009c816..ad7afe7544 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -876,8 +876,7 @@ static void spapr_nvdimm_realize(NVDIMMDevice *dimm, Error **errp)
>           s_nvdimm->hcall_flush_required = true;
>       }
>
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
> -                     &vmstate_spapr_nvdimm_states, dimm);
> +    vmstate_register_any(NULL, &vmstate_spapr_nvdimm_states, dimm);
>   }
>
>   static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> index 69c8863472..9afe8da831 100644
> --- a/hw/timer/arm_timer.c
> +++ b/hw/timer/arm_timer.c
> @@ -181,7 +181,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
>       s->control = TIMER_CTRL_IE;
>
>       s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
> -    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
> +    vmstate_register_any(NULL, &vmstate_arm_timer, s);
>       return s;
>   }
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 9dc3c61b5a..a5ea3be414 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -1119,8 +1119,8 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>       host_memory_backend_set_mapped(vmem->memdev, true);
>       vmstate_register_ram(&vmem->memdev->mr, DEVICE(vmem));
>       if (vmem->early_migration) {
> -        vmstate_register(VMSTATE_IF(vmem), VMSTATE_INSTANCE_ID_ANY,
> -                         &vmstate_virtio_mem_device_early, vmem);
> +        vmstate_register_any(VMSTATE_IF(vmem),
> +                             &vmstate_virtio_mem_device_early, vmem);
>       }
>       qemu_register_reset(virtio_mem_system_reset, vmem);
>

