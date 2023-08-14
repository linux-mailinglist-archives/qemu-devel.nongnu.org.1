Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8E77BD90
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVa2B-0004wy-TC; Mon, 14 Aug 2023 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVa24-0004me-PG
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVa22-0005Yi-8g
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692028981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGsDyZD2rSkHQeiiOMbpIZ03nJ1FNFusskT5AVL1luw=;
 b=gbkkJbbJhRkggsKXWLKMYj0Zck6whdBk799sUfrxxrEIxvtDa3VZLteijE8+YHlI2882ZY
 c94ZZHpauK6PAlg58NQqaYwhP1QJBAdNJRFMj8GMzZ5uwsFA4/4584Ad0qIxsVRXPdMn+Z
 TGvnnVgXwQ2SfZLyubpOML9JI32c2hw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-oOvJGCLxPcuIlsB-peWxqg-1; Mon, 14 Aug 2023 12:02:59 -0400
X-MC-Unique: oOvJGCLxPcuIlsB-peWxqg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe4cca36b7so30012735e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 09:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692028978; x=1692633778;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sGsDyZD2rSkHQeiiOMbpIZ03nJ1FNFusskT5AVL1luw=;
 b=LlbWTu/JfmtGNwasq/LH+qH25vCMMV7DEX9V1C7cSb7VdWh8zpdhbchIU6/EtT/uH6
 p3SDsYHrZAcbAv1S98W6wakPxrI2x+BFlnag8JwdQsi+JSoCGKCT+l/b5VjQW+rnsT2k
 C+RqsFBfK8TExOxys4xoD1JuIsJAN/Z9ol/oa19qHXhxJY7hZ/0JS2yZTs9J54X3j5ef
 QDlv5SNmhqwvykuoIpLJTdVAN+U21j0atUIWG2NHMS9PXg1d+dkkWufQjdJZ1cGJL6J1
 GJ9aYTirelfjEtUTSNfY77udXKMu+tVl8OMUuCMgbz82ZvwQiumUeCZ2l2szbtykoeng
 FHMw==
X-Gm-Message-State: AOJu0Yw93rPNH2cmzXAb1PzGTPiNV4I+A3Ko6yaZ+WFfj0dR+ftP5oeU
 ZX0CFKFve5SH9KRbn7y6lh5KMXjiC4O1G0xPDFJAEQVfcjI3QwhfjrrDVc63vt+9fgudtgxLTwB
 ugpZrxfePBb1n5Pw=
X-Received: by 2002:a7b:c4c5:0:b0:3fe:22fd:1b23 with SMTP id
 g5-20020a7bc4c5000000b003fe22fd1b23mr8004488wmk.34.1692028978456; 
 Mon, 14 Aug 2023 09:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLHyzL30ZMr/M4b7E5jOl9fkVbsSqa5UJaZFTm1fIKUYW21yAj+NYwimVNb/A33tJ/21sN2Q==
X-Received: by 2002:a7b:c4c5:0:b0:3fe:22fd:1b23 with SMTP id
 g5-20020a7bc4c5000000b003fe22fd1b23mr8004468wmk.34.1692028978157; 
 Mon, 14 Aug 2023 09:02:58 -0700 (PDT)
Received: from [192.168.8.105]
 (dynamic-046-114-244-033.46.114.pool.telefonica.de. [46.114.244.33])
 by smtp.gmail.com with ESMTPSA id
 26-20020a05600c22da00b003fbb618f7adsm14661101wmg.15.2023.08.14.09.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 09:02:57 -0700 (PDT)
Message-ID: <1a3d5379-74ad-3a85-0511-a6b0702c0daa@redhat.com>
Date: Mon, 14 Aug 2023 18:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20230804080415.56852-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-8.2] s390x: Convert DPRINTF to trace events
In-Reply-To: <20230804080415.56852-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.265, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04/08/2023 10.04, Cédric Le Goater wrote:
> Output message are slightly modified to ease selection with wildcards
> and to report extra parameters.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
...
> diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
> index 8b9213eab90c31d1eb37816d350bf76e902ccd10..34da5ea3230a0ac82f72a4d7a2aee047194be493 100644
> --- a/hw/s390x/trace-events
> +++ b/hw/s390x/trace-events
> @@ -19,3 +19,20 @@ virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-C
>   s390_pci_clp_cap(const char *id, uint32_t cap) "PCI: %s: missing expected CLP capability %u"
>   s390_pci_clp_cap_size(const char *id, uint32_t size, uint32_t cap) "PCI: %s: bad size (%u) for CLP capability %u"
>   s390_pci_clp_dev_info(const char *id) "PCI: %s: cannot read vfio device info"
> +
> +# s390-pci-bus.c
> +s390_pci_sclp_nodev(const char *str, uint32_t aid) "%s no dev found aid 0x%x"
> +s390_pci_iommu_xlate(uint64_t addr) "iommu trans addr 0x%" PRIx64
> +s390_pci_msi_ctrl_write(uint64_t data, uint32_t idx, uint32_t vec) "write_msix data 0x%" PRIx64 " idx %d vec 0x%x"
> +s390_pcihost(const char *msg) "%s"
> +
> +# s390-pci-inst.c
> +s390_pci_irqs(const char *str, uint32_t id) "%s irqs for adapter id %d"
> +s390_pci_kvm_aif(const char *str) "Failed to %s interrupt forwarding"
> +

Remove the empty line here?

> +s390_pci_list_entry(uint32_t g_l2, uint32_t vid, uint32_t did, uint32_t fid, uint32_t fh) "g_l2 %d vendor id 0x%x device id 0x%x fid 0x%x fh 0x%x"
> +s390_pci_list(uint32_t rc) "failed rc 0x%x"
> +s390_pci_unknown(const char *msg, uint32_t cmd) "%s unknown command 0x%x"
> +s390_pci_bar(uint32_t bar, uint32_t addr, uint64_t size, uint32_t barsize) "bar %d addr 0x%x size 0x%" PRIx64 "barsize 0x%x"
> +s390_pci_nodev(const char *cmd, uint32_t fh) "%s no pci dev fh 0x%x"
> +s390_pci_invalid(const char *cmd, uint32_t fh) "%s invalid space fh 0x%x"
> diff --git a/target/s390x/kvm/trace-events b/target/s390x/kvm/trace-events
> index 5289f5f6750e763c2e84f4d1626f70901a93d0ff..818f1a37a1525707ed0f61179ff03acb23fdf22c 100644
> --- a/target/s390x/kvm/trace-events
> +++ b/target/s390x/kvm/trace-events
> @@ -5,3 +5,10 @@ kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
>   kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
>   kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
>   kvm_assign_subch_ioeventfd(int fd, uint32_t addr, bool assign, int datamatch) "fd: %d sch: @0x%x assign: %d vq: %d"
> +
> +kvm_sw_breakpoint(uint32_t n) "KVM: will use %d-byte sw breakpoints"
> +kvm_insn_unhandled_priv(uint32_t x) "KVM: unhandled PRIV: 0x%x"
> +kvm_insn_diag(uint32_t x) "KVM: unknown DIAG: 0x%x"
> +kvm_insn(uint32_t ipa, uint32_t ipb) "handle_instruction 0x%x 0x%x"
> +kvm_intercept(uint32_t icpt_code, uint64_t psw_addr) "intercept: 0x%x (at 0x%"PRIx64"lx)"
> +kvm_msi_route_fixup(const char* msg) "%s"

Apart from the nit with the empty line:
Reviewed-by: Thomas Huth <thuth@redhat.com>


