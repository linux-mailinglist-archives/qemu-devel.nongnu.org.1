Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90502AB592F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 May 2025 17:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEs09-0003T1-7J; Tue, 13 May 2025 11:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEs07-0003SY-Kx
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEs04-0001Ay-Ed
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747151819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DEFG/nsmaD+Qs87+Cs7UWCDQ+3GwoOekcLYQ3v155tY=;
 b=TcDNc0zETe/7XjfvyZYiXwqsDLXEw9fb95uN2eZlC+tonkMC7yjHD8M8aMHkjiIlnirhc6
 IQ5J1bwIk9Y1u51aUX8C1wSSc9y3k+UNcaC4xyo0e+Vqzvoe2UCLDEiIxIConrxFD028sF
 f8EVyjsASLjdvn2EZzIWL42nOuuOzoM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-niJYAd0zMdu9vAJhOR_wng-1; Tue,
 13 May 2025 11:56:56 -0400
X-MC-Unique: niJYAd0zMdu9vAJhOR_wng-1
X-Mimecast-MFC-AGG-ID: niJYAd0zMdu9vAJhOR_wng_1747151812
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42CCB195DE39; Tue, 13 May 2025 15:56:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A941953B82; Tue, 13 May 2025 15:56:40 +0000 (UTC)
Date: Tue, 13 May 2025 16:56:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 08/10] arm/cpu: more customization for the kvm host
 cpu model
Message-ID: <aCNrtM2U7OBKsnjQ@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-9-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414163849.321857-9-cohuck@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Apr 14, 2025 at 06:38:47PM +0200, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> If the interface for writable ID registers is available, expose uint64
> SYSREG properties for writable ID reg fields exposed by the host
> kernel. Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
> being those used  in linux arch/arm64/tools/sysreg. This done by
> matching the writable fields retrieved from the host kernel against the
> generated description of sysregs.
> 
> An example of invocation is:
> -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> which sets DP field of ID_AA64ISAR0_EL1 to 0.

Functionally this works, but stylewise it is rather too verbose
IMHO. I understand this aims to mtch the arm feature names, but
we can at least drop the SYSREG_ prefix here which IMHO doesn't
add much value. The <REG> component only has a small number of
possible prefixes, so it seems pretty unlikely we would get a
name clash between these and some other QOM property.

Also could we stick with lowercase, rather than uppercase. I
appreciate the spec uses uppercase, but that doesn't concern
itself with end user usage. If we just plain transform everything
to lowercase, there's still a clear mapping to the spec that
people will understand [1].

This example uses '-cpu host', but does this also work
with '-cpu max'  ?

Conceptually '-cpu max' is supposed to be functionally identical
to '-cpu host' when KVM is enabled. Obviously you'd ned to
exclude it from '-cpu max' with TCG or other non-KVM accels.


> +/*
> + * decode_idreg_writemap: Generate props for writable fields
> + *
> + * @obj: CPU object
> + * @index: index of the sysreg
> + * @map: writable map for the sysreg
> + * @reg: description of the sysreg
> + */
> +static int
> +decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
> +{
> +    int i = ctz64(map);
> +    int nb_sysreg_props = 0;
> +
> +    while (map) {
> +
> +        ARM64SysRegField *field = get_field(i, reg);
> +        int lower, upper;
> +        uint64_t mask;
> +        char *prop_name;
> +
> +        if (!field) {
> +            /* the field cannot be matched to any know id named field */
> +            warn_report("%s bit %d of %s is writable but cannot be matched",
> +                        __func__, i, reg->name);
> +            warn_report("%s is cpu-sysreg-properties.c up to date?", __func__);

What scenario triggers this warning ? Is this in relation to QEMU
auto-detecting host CPU features, as opposed to user -cpu input ?

> +            map =  map & ~BIT_ULL(i);
> +            i = ctz64(map);
> +            continue;
> +        }
> +        lower = field->lower;
> +        upper = field->upper;
> +        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
> +        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
> +        object_property_add(obj, prop_name, "uint64",
> +                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> +        nb_sysreg_props++;
> +
> +        mask = MAKE_64BIT_MASK(lower, upper - lower + 1);
> +        map = map & ~mask;
> +        i = ctz64(map);
> +    }
> +    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> +    return 0;
> +}
> +
> +/* analyze the writable mask and generate properties for writable fields */
> +void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
> +{
> +    int i, idx;
> +    IdRegMap *map = cpu->writable_map;
> +    Object *obj = OBJECT(cpu);
> +
> +    for (i = 0; i < NR_ID_REGS; i++) {
> +        uint64_t mask = map->regs[i];
> +
> +        if (mask) {
> +            /* reg @i has some writable fields, decode them */
> +            idx = kvm_idx_to_idregs_idx(i);
> +            if (idx < 0) {
> +                /* no matching reg? */
> +                warn_report("%s: reg %d writable, but not in list of idregs?",
> +                            __func__, i);
> +            } else {
> +                decode_idreg_writemap(obj, i, mask, &regs[idx]);
> +            }
> +        }
> +    }
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


