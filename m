Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B37752157
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvYd-0001qc-EV; Thu, 13 Jul 2023 08:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1qJvYa-0001pz-2e
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:36:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1qJvYV-00066h-Ei
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:36:27 -0400
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1vG34C5Fz18LjR;
 Thu, 13 Jul 2023 20:35:23 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:35:57 +0800
Subject: Re: [PATCH V9 32/46] vfio-pci: cpr part 2 (msi)
To: Steven Sistare <steven.sistare@oracle.com>, <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Jason Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
 <zhengchuan@huawei.com>, Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu
 <tugy@chinatelecom.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>,
 John Snow <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>, Eric Auger
 <eric.auger@redhat.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <1658851843-236870-33-git-send-email-steven.sistare@oracle.com>
 <8f79e5cb-aa6b-8bff-d0ec-f62fc929f669@huawei.com>
 <eafc9251-4b5c-d905-4e92-e6b02f3c2c56@oracle.com>
Message-ID: <3f84f075-c9ac-c238-21b7-be8bcd6cdccc@huawei.com>
Date: Thu, 13 Jul 2023 20:35:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eafc9251-4b5c-d905-4e92-e6b02f3c2c56@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=jiangkunkun@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Kunkun Jiang <jiangkunkun@huawei.com>
From:  Kunkun Jiang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Steve,

On 2023/7/10 23:43, Steven Sistare wrote:
> On 7/5/2023 4:56 AM, Kunkun Jiang wrote:
>> Hi Steve,
>>
>> I have a few questions about the msi part of the vfio device.
>> In the reboot mode, you mentioned "The guest drivers' suspend methods
>> flush outstanding requests and re-initialize the devices". This means,
>> during the downtime,the vfio device dose not generate interrupts. So
>> no special processing is required for the msi interrupt of the vfio
>> device. Am I right?
> Correct.
>
>> In the cpr-exec mode, will the vfio device be "stopped"? If the vfio device
>> is running all the time,it is possible to generate interrrupts during the
>> downtime. How to deal with these interrupts?
> The vfio device is not stopped, but its connection to the kvm instance is severed.
> Interrupts are pended in the vfio kernel state, and that state is preserved across
> exec, by preserving the vfio descriptors.  After exec, qemu creates a new kvm instance,
> attaches vfio to it, and the interrupts are delivered.
>
>> In addition, ARM GICv4 provides support for the direct injection of vLPIs.
>> Interrupts are more difficult to handle. In this case, what should be done?
> I have not studied this feature or tried it.
Have you analyzed the VT-D post-interrupt feature? It is similar to the 
direct
injection of vLPI. They all implement the interrupt injecting channel by 
executing
irq_bypass_register_consumer.

According to the current kernel code, it need to first cancel the 
connection between
vfio producer and kvm consumer, then establishes the connection between 
vfio producer
and the new kvm consumer. During the unbinding process, both ARM and x86 
will execute
the callback of *_set_vcpu_affinity to modify the interrupt reporting 
channel. For x86,
in the process of stop posting interrupts, back to remapping mode, 
cmpxchg_double is
used in the code. Does this guarantee that interrupts will not be lost?

For ARM, it will first send a DISCARD command to ITS and then establish 
the interrupt
reporting channel for GICv3. The DISCARD will remove the pending 
interrupt. Interrupts
that come before channel re-establishment are silently discarded.
Do you guys have any good ideas?

Look forward to your reply.
Kunkun Jiang
>
> - Steve
>
>> Look forward to your reply.
>>
>> Kunkun Jiang
>>
>> On 2022/7/27 0:10, Steve Sistare wrote:
>>> Finish cpr for vfio-pci MSI/MSI-X devices by preserving eventfd's and
>>> vector state.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    hw/vfio/pci.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 118 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index b5fd2ec..1d0e8db 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -54,17 +54,47 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>>    static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>>    static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>>>    +#define EVENT_FD_NAME(vdev, name)   \
>>> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>>> +
>>> +static void save_event_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>>> +                          EventNotifier *ev)
>>> +{
>>> +    int fd = event_notifier_get_fd(ev);
>>> +
>>> +    if (fd >= 0) {
>>> +        g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>>> +
>>> +        cpr_resave_fd(fdname, nr, fd);
>>> +    }
>>> +}
>>> +
>>> +static int load_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>>> +{
>>> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>>> +    return cpr_find_fd(fdname, nr);
>>> +}
>>> +
>>> +static void delete_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>>> +{
>>> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>>> +    cpr_delete_fd(fdname, nr);
>>> +}
>>> +
>>>    /* Create new or reuse existing eventfd */
>>>    static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>>                                  const char *name, int nr)
>>>    {
>>> -    int fd = -1;   /* placeholder until a subsequent patch */
>>>        int ret = 0;
>>> +    int fd = load_event_fd(vdev, name, nr);
>>>          if (fd >= 0) {
>>>            event_notifier_init_fd(e, fd);
>>>        } else {
>>>            ret = event_notifier_init(e, 0);
>>> +        if (!ret) {
>>> +            save_event_fd(vdev, name, nr, e);
>>> +        }
>>>        }
>>>        return ret;
>>>    }
>>> @@ -72,6 +102,7 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>>    static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>>>                                      const char *name, int nr)
>>>    {
>>> +    delete_event_fd(vdev, name, nr);
>>>        event_notifier_cleanup(e);
>>>    }
>>>    @@ -512,6 +543,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>>        VFIOMSIVector *vector;
>>>        int ret;
>>>    +    /*
>>> +     * Ignore the callback from msix_set_vector_notifiers during resume.
>>> +     * The necessary subset of these actions is called from vfio_claim_vectors
>>> +     * during post load.
>>> +     */
>>> +    if (vdev->vbasedev.reused) {
>>> +        return 0;
>>> +    }
>>> +
>>>        trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>>>          vector = &vdev->msi_vectors[nr];
>>> @@ -2784,6 +2824,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>>        fd = event_notifier_get_fd(&vdev->err_notifier);
>>>        qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>>>    +    /* Do not alter irq_signaling during vfio_realize for cpr */
>>> +    if (vdev->vbasedev.reused) {
>>> +        return;
>>> +    }
>>> +
>>>        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>>            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>> @@ -2849,6 +2894,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>>        fd = event_notifier_get_fd(&vdev->req_notifier);
>>>        qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>>>    +    /* Do not alter irq_signaling during vfio_realize for cpr */
>>> +    if (vdev->vbasedev.reused) {
>>> +        vdev->req_enabled = true;
>>> +        return;
>>> +    }
>>> +
>>>        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>>>                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>>            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>> @@ -3357,6 +3408,46 @@ static Property vfio_pci_dev_properties[] = {
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>    +static void vfio_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors, bool msix)
>>> +{
>>> +    int i, fd;
>>> +    bool pending = false;
>>> +    PCIDevice *pdev = &vdev->pdev;
>>> +
>>> +    vdev->nr_vectors = nr_vectors;
>>> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
>>> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
>>> +
>>> +    vfio_prepare_kvm_msi_virq_batch(vdev);
>>> +
>>> +    for (i = 0; i < nr_vectors; i++) {
>>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>>> +
>>> +        fd = load_event_fd(vdev, "interrupt", i);
>>> +        if (fd >= 0) {
>>> +            vfio_vector_init(vdev, i);
>>> +            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
>>> +        }
>>> +
>>> +        if (load_event_fd(vdev, "kvm_interrupt", i) >= 0) {
>>> +            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
>>> +        } else {
>>> +            vdev->msi_vectors[i].virq = -1;
>>> +        }
>>> +
>>> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
>>> +            set_bit(i, vdev->msix->pending);
>>> +            pending = true;
>>> +        }
>>> +    }
>>> +
>>> +    vfio_commit_kvm_msi_virq_batch(vdev);
>>> +
>>> +    if (msix) {
>>> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
>>> +    }
>>> +}
>>> +
>>>    /*
>>>     * The kernel may change non-emulated config bits.  Exclude them from the
>>>     * changed-bits check in get_pci_config_device.
>>> @@ -3375,6 +3466,29 @@ static int vfio_pci_pre_load(void *opaque)
>>>        return 0;
>>>    }
>>>    +static int vfio_pci_post_load(void *opaque, int version_id)
>>> +{
>>> +    VFIOPCIDevice *vdev = opaque;
>>> +    PCIDevice *pdev = &vdev->pdev;
>>> +    int nr_vectors;
>>> +
>>> +    if (msix_enabled(pdev)) {
>>> +        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
>>> +                                   vfio_msix_vector_release, NULL);
>>> +        nr_vectors = vdev->msix->entries;
>>> +        vfio_claim_vectors(vdev, nr_vectors, true);
>>> +
>>> +    } else if (msi_enabled(pdev)) {
>>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>>> +        vfio_claim_vectors(vdev, nr_vectors, false);
>>> +
>>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>>> +        assert(0);      /* completed in a subsequent patch */
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static bool vfio_pci_needed(void *opaque)
>>>    {
>>>        return migrate_mode() == MIG_MODE_CPR_EXEC;
>>> @@ -3386,8 +3500,11 @@ static const VMStateDescription vfio_pci_vmstate = {
>>>        .minimum_version_id = 0,
>>>        .priority = MIG_PRI_VFIO_PCI,       /* must load before container */
>>>        .pre_load = vfio_pci_pre_load,
>>> +    .post_load = vfio_pci_post_load,
>>>        .needed = vfio_pci_needed,
>>>        .fields = (VMStateField[]) {
>>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>>            VMSTATE_END_OF_LIST()
>>>        }
>>>    };
> .

