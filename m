Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCA78D74B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:52:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNUK-0005E9-0g; Wed, 30 Aug 2023 11:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNUH-0005E0-OD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNUF-0005so-A6
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693410725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyuUzRd77VMVQp5rs+43yGafab14jE0ZGbu0hpEqKMg=;
 b=g8ROOn1gGMM6BdpUn+i8kftjJZpoNib1yRF19mK6qV7ijSNeddhcpmJ/hqA8vBSEb5JdDW
 gqxzY1AkKrDNv4+3/8C6NNjGgwU0Dt6/xJr8EbAeHo6vG4EDjtWrpG/+FuaJ3apd5d32/i
 VEVVTQBQGxpZtki2Xm9EjnrCZfiJaHA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-qj0AFoa2OBu3tD3-uGjGsQ-1; Wed, 30 Aug 2023 11:52:04 -0400
X-MC-Unique: qj0AFoa2OBu3tD3-uGjGsQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4122babcb87so9891761cf.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693410724; x=1694015524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyuUzRd77VMVQp5rs+43yGafab14jE0ZGbu0hpEqKMg=;
 b=T8F0gI0Vfc6ItDf2DePxN0wyAvhsBR/68uZtzxbYf5zLkEt+fJTkkLL1F2L7nB6MyI
 2rQ2iYjm93AWasZRjTZQty0y/a68FBIPvLJESPIzrOYgeZniHqt1HDmwCgTXss5CC7xE
 oSPWeDpyFDV6o4QHqxAQFxz4dsvoW55CGAyU4+K70H18eBzqkSFjD2wzfjzuJIZp19ZO
 Ip9baS9RSW+DgpURb+ooabyw5DPXzCkgn6eJUytXbGZNLBfRLzXySWIQBh9+O75UFtid
 4ym5yF7AFW+bqBBPd7mkuapcUCcEkvtNWz/aCQPMK8NHGm6IhM03Xa16Ll1iHEzMfmop
 1qPQ==
X-Gm-Message-State: AOJu0YzA53j09AVKWoKM0ITdsX+hFvTULJdMpSgo0mp317HHXPCyx9+Q
 qcWxbfEJiahC3T/9Ejn0QQXHPRjVKfU8zAk0zPRWaHzN+nVxWcunGlikcWUVQua4P6QDTAvIWc+
 WoS5QZ5Ne7XTW0So=
X-Received: by 2002:a05:622a:1807:b0:412:d46:a8c3 with SMTP id
 t7-20020a05622a180700b004120d46a8c3mr2871565qtc.2.1693410723838; 
 Wed, 30 Aug 2023 08:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmZ6pP3VXZTuM/cynHw11cugWkQ0T7WNPmf9ysg8zDB3Biuw2z8/HlE2/E55iOCN708NW8Zw==
X-Received: by 2002:a05:622a:1807:b0:412:d46:a8c3 with SMTP id
 t7-20020a05622a180700b004120d46a8c3mr2871550qtc.2.1693410723515; 
 Wed, 30 Aug 2023 08:52:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x11-20020ac87ecb000000b004108bebd1fcsm3772130qtj.24.2023.08.30.08.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:52:02 -0700 (PDT)
Date: Wed, 30 Aug 2023 11:52:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 01/11] cpus: pass runstate to vm_prepare_start
Message-ID: <ZO9loC9zzEAwZJjK@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 11:17:56AM -0700, Steve Sistare wrote:
> When a vm in the suspended state is migrated, we must call vm_prepare_start
> on the destination, so a later system_wakeup properly resumes the guest,
> when main_loop_should_exit callsresume_all_vcpus.  However, the runstate
> should remain suspended until system_wakeup is called, so allow the caller
> to pass the new state to vm_prepare_start, rather than assume the new state
> is RUN_STATE_RUNNING.  Modify vm state change handlers that check
> RUN_STATE_RUNNING to instead use the running parameter.
> 
> No functional change.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I think all the call sites should be covered indeed, via:

qemu_add_vm_change_state_handler_prio
    qdev_add_vm_change_state_handler
        virtio_blk_device_realize[1653] qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
        scsi_qdev_realize[289]         dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
        vfio_migration_init[796]       migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
        virtio_init[3189]              vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
    qemu_add_vm_change_state_handler
        xen_init[106]                  qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
        audio_init[1827]               e = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
        tpm_emulator_inst_init[978]    qemu_add_vm_change_state_handler(tpm_emulator_vm_state_change,
        blk_root_activate[223]         blk->vmsh = qemu_add_vm_change_state_handler(blk_vm_state_changed,
        gdbserver_start[384]           qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
        pflash_post_load[1038]         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
        qxl_realize_common[2202]       qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
        kvmclock_realize[233]          qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
        kvm_pit_realizefn[298]         qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
        vapic_post_load[796]           qemu_add_vm_change_state_handler(kvmvapic_vm_state_change, s);
        ide_bus_register_restart_cb[2767] bus->vmstate = qemu_add_vm_change_state_handler(ide_restart_cb, bus);
        kvm_arm_its_realize[122]       qemu_add_vm_change_state_handler(vm_change_state_handler, s);
        kvm_arm_gicv3_realize[888]     qemu_add_vm_change_state_handler(vm_change_state_handler, s);
        kvmppc_xive_connect[794]       xive->change = qemu_add_vm_change_state_handler(
        via1_post_load[971]            v1s->vmstate = qemu_add_vm_change_state_handler(
        e1000e_core_pci_realize[3379]  qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
        igb_core_pci_realize[4012]     core->vmstate = qemu_add_vm_change_state_handler(igb_vm_state_change, core);
        spapr_nvram_post_load[235]     nvram->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
        ppc_booke_timers_init[366]     qemu_add_vm_change_state_handler(cpu_state_change_handler, cpu);
        spapr_machine_init[3070]       qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
        kvm_s390_tod_realize[133]      qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
        usb_ehci_realize[2540]         s->vmstate = qemu_add_vm_change_state_handler(usb_ehci_vm_state_change, s);
        usb_host_auto_check[1912]      usb_vmstate = qemu_add_vm_change_state_handler(usb_host_vm_state, NULL);
        usbredir_realize[1466]         qemu_add_vm_change_state_handler(usbredir_vm_state_change, dev);
        virtio_rng_device_realize[226] vrng->vmstate = qemu_add_vm_change_state_handler(virtio_rng_vm_state_change,
        xen_do_ioreq_register[825]     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
        net_init_clients[1644]         qemu_add_vm_change_state_handler(net_vm_change_state_handler, NULL);
        memory_global_dirty_log_stop[2978] vmstate_change = qemu_add_vm_change_state_handler(
        hvf_arch_init[2036]            qemu_add_vm_change_state_handler(hvf_vm_state_change, &vtimer);
        kvm_arch_init_vcpu[567]        qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
        kvm_arch_init_vcpu[2191]       cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
        sev_kvm_init[1014]             qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
        whpx_init_vcpu[2248]           qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
        kvm_arch_init_vcpu[70]         qemu_add_vm_change_state_handler(kvm_mips_update_state, cs);
        kvm_arch_init_vcpu[891]        qemu_add_vm_change_state_handler(kvm_riscv_vm_state_change, cs);
        gtk_display_init[2410]         qemu_add_vm_change_state_handler(gd_change_runstate, s);
        qemu_spice_display_init_done[651] qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
        qemu_spice_add_interface[868]  qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);

Looks all correct:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


