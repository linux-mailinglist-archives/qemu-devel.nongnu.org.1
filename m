Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E07A9334
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGBQ-0003SJ-W0; Thu, 21 Sep 2023 05:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjGBO-0003S8-T7
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjGBN-0006NV-4O
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695289272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vVeVks5/eAMBSt2itTQQchvGUB536V27ivXYIGhahA=;
 b=YXPed7jnSHLMT/YD33nmJlLlsLsvYtVeqkmDl2qBdXHGItlLA1GrFxnGW36fCZ33L2DxvX
 NymFdL33kfwpMHpAWdL6CQTPRTFxZeZ8EtBCYCNYiPErYogs2C6/rKSEGRvmyGHbunZnBm
 2zFb6QQUAGaO7cg4BO9ORdzsa5XgYCk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-CTLHEk7HPG67UfTGeaKsSw-1; Thu, 21 Sep 2023 05:41:09 -0400
X-MC-Unique: CTLHEk7HPG67UfTGeaKsSw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-68fc7be8224so831494b3a.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695289269; x=1695894069;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vVeVks5/eAMBSt2itTQQchvGUB536V27ivXYIGhahA=;
 b=jUmCZjTLf5uUUyB136kL5TmKqLPzR4z9tRJnl7zGmIxYQT+7MvyVQgDCYifFBjf1S8
 Wv0sOhWDbBB54i4+0EPWaRODee/p/DkN7LdJy6fxtJ+zcZ8nZZQVZnEyb6CyxEKX60ky
 mbpDNYjrKv4w98Oou5aySCKomcxqbhZK5Vep0FBmj/jLDFi68QkUd2GohmTOCixgWuc7
 +Z8+j7H7mqM+tHoRG5hj/zzIqMEmp22Mpu2GKPkhOXjJpE3Kg+z36b4t+/tN4D5dILKx
 pSe9mJxMy5z9SumFUMg5GuqtePygH/rKEyemqSEEwS9CjVstjt5UBHHQr4VkRpMc5u8i
 6U0A==
X-Gm-Message-State: AOJu0Yx1XAEwuBqbSHgh3SFEBhAIiS6I80vKKfgJPYCavUZDGQlsG6q0
 GbairjcO10mEz8C3PxdGTXQ2qlE+qvdwMGGOrNRFjnd4z6FQUEqIF12GnIjTUj1SJvVb/4JZjwj
 fAveM2sPG9NbYe6w=
X-Received: by 2002:a05:6a00:2d23:b0:68c:6a77:4845 with SMTP id
 fa35-20020a056a002d2300b0068c6a774845mr5605539pfb.12.1695289268732; 
 Thu, 21 Sep 2023 02:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUYlbnYlRAmh0ke4ZH0CZ0Pr/F98q58jVn2nwifEqB8lgzC/ij0JHCgRGzysANAptNtArm8w==
X-Received: by 2002:a05:6a00:2d23:b0:68c:6a77:4845 with SMTP id
 fa35-20020a056a002d2300b0068c6a774845mr5605523pfb.12.1695289268342; 
 Thu, 21 Sep 2023 02:41:08 -0700 (PDT)
Received: from smtpclient.apple ([115.96.26.17])
 by smtp.gmail.com with ESMTPSA id
 bi17-20020a056a00311100b00682bec0b680sm934197pfb.89.2023.09.21.02.41.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Sep 2023 02:41:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v3] hw/i386/pc: improve physical address space bound check
 for 32-bit systems
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9b9e4ee5-7ab3-3c61-8e50-3d3a9533b15b@redhat.com>
Date: Thu, 21 Sep 2023 15:11:02 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, philmd@linaro.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <516D5AF4-A100-46C1-9F77-0F96BE5CA545@redhat.com>
References: <20230921071755.61081-1-anisinha@redhat.com>
 <9b9e4ee5-7ab3-3c61-8e50-3d3a9533b15b@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 21-Sep-2023, at 1:45 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 21.09.23 09:17, Ani Sinha wrote:
>> 32-bit systems do not have a reserved memory for hole64 and =
hotplugging memory
>> devices are not supported on those systems. Therefore, the maximum =
limit of the
>> guest physical address in the absence of additional memory devices =
effectively
>> coincides with the end of "above 4G memory space" region. When users =
configure
>> additional memory devices, we need to properly account for the =
additional device
>> memory region so as to find the maximum value of the guest physical =
address
>> and enforce that it is within the physical address space of the =
processor. For
>> 32-bit, this maximum PA will be outside the range of the processor's =
address
>> space.
>> With this change, for example, previously this was allowed:
>> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
>> Now it is no longer allowed:
>> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
>> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff =
phys-bits too low (32)
>> For 32-bit, hotplugging additional memory is no longer allowed.
>=20
> "32-bit without PAE/PSE36"
>=20
>> $ ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2
>> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff =
phys-bits too low (32)
>=20
> We always place the device memory region above 4G. Without PAE/PSE36, =
you cannot ever possibly make use hotplugged memory, because it would =
reside > 4g.
>=20
> So while the user could have started that QEMU instance, even with an =
OS that would support memory hotplug, a DIMM above 4G would not have =
been usable.
>=20
> So we're now properly failing for a setup that doesn't make any sense. =
Good :)
>=20
> ... if someone ever cares about making that work, we would have to let =
the device memory region start below 4g (and obviously, not exceed 4g).
>=20
>=20
> So while
>=20
> ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2
>=20
> fails (because pentium cannot access that memory), what should work is
>=20
> ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2 -cpu pentium2
>=20
> or
>=20
> ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2 -cpu =
pentium,pse36=3Don
>=20
> Because that CPU could actually address that memory somehow =
(PAE/PSE36).
>=20
>=20
> So IMHO, we're now forbidding setups that are impossible.
>=20
>> The above is still allowed for older machine types in order to =
support
>> compatibility. Therefore, this still works:
>> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m =
size=3D1G,maxmem=3D3G,slots=3D2
>=20
> Makes sense. (probably nobody cares, but better safe than sorry)
>=20
>> After calling CPUID with EAX=3D0x80000001, all AMD64 compliant =
processors
>> have the longmode-capable-bit turned on in the extended feature flags =
(bit 29)
>> in EDX. The absence of CPUID longmode can be used to differentiate =
between
>> 32-bit and 64-bit processors and is the recommended approach. QEMU =
takes this
>> approach elsewhere (for example, please see x86_cpu_realizefn()) and =
with
>> this change, pc_max_used_gpa() also takes the same approach to detect =
32-bit
>> processors.
>> Unit tests are modified to not run those tests that use memory =
hotplug
>> on 32-bit x86 architecture.
>=20
> We could use a different CPU (pentium2) to still run these tests. =
"pentium2" should work I assume?

Yes it does.

> [...]
>=20
>> @@ -907,12 +907,39 @@ static uint64_t =
pc_get_cxl_range_end(PCMachineState *pcms)
>>  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t =
pci_hole64_size)
>>  {
>>      X86CPU *cpu =3D X86_CPU(first_cpu);
>> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>> +    MachineState *ms =3D MACHINE(pcms);
>> +    uint64_t devmem_start =3D 0;
>> +    ram_addr_t devmem_size =3D 0;
>>  -    /* 32-bit systems don't have hole64 thus return max CPU address =
*/
>> -    if (cpu->phys_bits <=3D 32) {
>> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
>> +    /*
>> +     * 32-bit systems don't have hole64 but they might have a region =
for
>> +     * memory devices. Even if additional hotplugged memory devices =
might
>> +     * not be usable by most guest OSes, we need to still consider =
them for
>> +     * calculating the highest possible GPA so that we can properly =
report
>> +     * if someone configures them on a CPU that cannot possibly =
address them.
>> +     */
>> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
>> +        /* 32-bit systems */
>> +        if (pcmc->fixed_32bit_mem_addr_check) {
>> +            if (pcmc->has_reserved_memory &&
>> +                (ms->ram_size < ms->maxram_size)) {
>> +                pc_get_device_memory_range(pcms, &devmem_start,
>> +                                           &devmem_size);
>> +                if (!pcmc->broken_reserved_end) {
>=20
> I think you can remove that check. "pcmc->fixed_32bit_mem_addr_check =
&& pcmc->broken_reserved_end" can never hold at the same time.

Yeah my bad, I was being too defensive. Will remove.

>=20
> broken_reserved_end is only set for QEMU <=3D 2.4, to work around =
another broken check. pcmc->fixed_32bit_mem_addr_check is only set for =
8.2+.
>=20
> Maybe consider calling "fixed_32bit_mem_addr_check" =
"pcmc->broken_32bit_max_gpa_check" and reverse the logic (treating it =
like broken_reserved_end).

Will fix next version.

>=20
>=20
> --=20
> Cheers,
>=20
> David / dhildenb


