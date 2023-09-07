Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DA796F48
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5jD-0004Qk-2H; Wed, 06 Sep 2023 23:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe5j9-0004Ml-GQ; Wed, 06 Sep 2023 23:30:44 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe5j4-0002cZ-UX; Wed, 06 Sep 2023 23:30:41 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-76ef935abaeso32733785a.2; 
 Wed, 06 Sep 2023 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694057437; x=1694662237; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEaemtnvwEhnedBlm6NfpCIM3D9kxx7x22kRwzyzRcU=;
 b=bFkrwTqVDilTJhW2OCYFkpdBxkJVL0SsX0/R5xeUkoNue7N2WaPzTv0lXFxe1rKZZ1
 cQGholUw33a44ixJHxfPMwdWhxtcRCFaT4aPlSIKJWWXx7XMXbssXD5j7DGbKB0A1vg1
 kkDihUHw5WnWcaNfYGXocnQqG7POzrxAdUxgRH/PGzjyMfoKT00I0LTLprb8e3iGdP9g
 JEb8xI/zQUMcY0Jjzko/AU7cmgt80+J53tUyBihiyXeXfDnnwhzjnS4GO4lb1sMWshaz
 T+zsuPn2Ed1qVZW0acndpXzRaugUBggxgLX/8syzs+Le3mOwHwvPwMJejGkPydhKb0Nh
 AFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694057437; x=1694662237;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jEaemtnvwEhnedBlm6NfpCIM3D9kxx7x22kRwzyzRcU=;
 b=jrS8ed/uvO9I8GWJFA/BFkzENK+8Z1HnmHaHmmkG+FRpSkKWl+YAP3jWFPWdeqF55c
 ET9ru9bLBOC6QcTWgDdW/mZivQWGYgFw7EqGY0I5DJbAj+kTJi0EDfbMLS9DK/BQx9jV
 +f2jbn1U2r47PhZukLGot7zaUeBj8fuaME+1QRME1gxXXXzlqcfPm5HVLCrhGEngvqYE
 Oab5jfPxcb7pFbVoDcX9yvaEJ6/YzN5VXSJtcWL/3bdQfdvLPW/TBJZh6Nb2y+hTg/80
 jIoR2YgouVI2+ybPKr/LbMKuNCwfV6w9TK89RX8FOGBPPSD9hf1nzRDafa4BGvIpcHLx
 /A8w==
X-Gm-Message-State: AOJu0YwHJ0YdbV4OOYKOuRctrJjdryJVuNIzeL2eVXyFHZy5wsu0pMBp
 AXjY3OMzSFTD+nvGC+y3Di0=
X-Google-Smtp-Source: AGHT+IGh11rTQltZRWtNxhHou0TD/8HQI8rZTTe6h3A5RY7N4GCjXOEbpRt5F/OEnxz/B4DI9KEp0A==
X-Received: by 2002:a05:620a:2953:b0:76d:a03e:73bf with SMTP id
 n19-20020a05620a295300b0076da03e73bfmr23473826qkp.32.1694057437437; 
 Wed, 06 Sep 2023 20:30:37 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 j2-20020aa783c2000000b00672ea40b8a9sm11893793pfn.170.2023.09.06.20.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 20:30:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 13:30:31 +1000
Message-Id: <CVCD8OCRI1FI.19OOXLKWHGZ00@wheely>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 11/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_[GET|SET]_STATE
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-12-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-12-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=npiggin@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
> L1 can reuest to get/set state of any of the supported Guest State
> Buffer (GSB) elements using h_guest_[get|set]_state hcalls.
> These hcalls needs to do some necessary validation check for each
> get/set request based on the flags passed and operation supported.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c         | 267 ++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_nested.h |  22 +++
>  2 files changed, 289 insertions(+)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 6fbb1bcb02..498e7286fa 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -897,6 +897,138 @@ void init_nested(void)
>      }
>  }
> =20
> +static struct guest_state_element *guest_state_element_next(
> +    struct guest_state_element *element,
> +    int64_t *len,
> +    int64_t *num_elements)
> +{
> +    uint16_t size;
> +
> +    /* size is of element->value[] only. Not whole guest_state_element *=
/
> +    size =3D be16_to_cpu(element->size);
> +
> +    if (len) {
> +        *len -=3D size + offsetof(struct guest_state_element, value);
> +    }
> +
> +    if (num_elements) {
> +        *num_elements -=3D 1;
> +    }
> +
> +    return (struct guest_state_element *)(element->value + size);
> +}
> +
> +static
> +struct guest_state_element_type *guest_state_element_type_find(uint16_t =
id)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(guest_state_element_types); i++)
> +        if (id =3D=3D guest_state_element_types[i].id) {
> +            return &guest_state_element_types[i];
> +        }
> +
> +    return NULL;
> +}
> +
> +static void print_element(struct guest_state_element *element,
> +                          struct guest_state_request *gsr)
> +{
> +    printf("id:0x%04x size:0x%04x %s ",
> +           be16_to_cpu(element->id), be16_to_cpu(element->size),
> +           gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get");
> +    printf("buf:0x%016lx ...\n", be64_to_cpu(*(uint64_t *)element->value=
));

No printfs. These could be GUEST_ERROR qemu logs if anything, make
sure they're relatively well formed messages if you keep them, i.e.,
something a Linux/KVM developer could understand what went wrong.
I.e., no __func__ which is internal to QEMU, use "H_GUEST_GET_STATE"
etc. Ditto for all the rest of the printfs.

> +}
> +
> +static bool guest_state_request_check(struct guest_state_request *gsr)
> +{
> +    int64_t num_elements, len =3D gsr->len;
> +    struct guest_state_buffer *gsb =3D gsr->gsb;
> +    struct guest_state_element *element;
> +    struct guest_state_element_type *type;
> +    uint16_t id, size;
> +
> +    /* gsb->num_elements =3D 0 =3D=3D 32 bits long */
> +    assert(len >=3D 4);

I haven't looked closely, but can the guest can't crash the
host with malformed requests here?

This API is pretty complicated, make sure you sanitize all inputs
carefully, as early as possible, and without too deep a call and
control flow chain from the API entry point.


> +
> +    num_elements =3D be32_to_cpu(gsb->num_elements);
> +    element =3D gsb->elements;
> +    len -=3D sizeof(gsb->num_elements);
> +
> +    /* Walk the buffer to validate the length */
> +    while (num_elements) {
> +
> +        id =3D be16_to_cpu(element->id);
> +        size =3D be16_to_cpu(element->size);
> +
> +        if (false) {
> +            print_element(element, gsr);
> +        }
> +        /* buffer size too small */
> +        if (len < 0) {
> +            return false;
> +        }
> +
> +        type =3D guest_state_element_type_find(id);
> +        if (!type) {
> +            printf("%s: Element ID %04x unknown\n", __func__, id);
> +            print_element(element, gsr);
> +            return false;
> +        }
> +
> +        if (id =3D=3D GSB_HV_VCPU_IGNORED_ID) {
> +            goto next_element;
> +        }
> +
> +        if (size !=3D type->size) {
> +            printf("%s: Size mismatch. Element ID:%04x. Size Exp:%i Got:=
%i\n",
> +                   __func__, id, type->size, size);
> +            print_element(element, gsr);
> +            return false;
> +        }
> +
> +        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
> +            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
> +            printf("%s: trying to set a read-only Element ID:%04x.\n",
> +                   __func__, id);
> +            return false;
> +        }
> +
> +        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
> +            /* guest wide element type */
> +            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
> +                printf("%s: trying to set a guest wide Element ID:%04x.\=
n",
> +                       __func__, id);
> +                return false;
> +            }
> +        } else {
> +            /* thread wide element type */
> +            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
> +                printf("%s: trying to set a thread wide Element ID:%04x.=
\n",
> +                       __func__, id);
> +                return false;
> +            }
> +        }
> +next_element:
> +        element =3D guest_state_element_next(element, &len, &num_element=
s);
> +
> +    }
> +    return true;
> +}
> +
> +static bool is_gsr_invalid(struct guest_state_request *gsr,
> +                                   struct guest_state_element *element,
> +                                   struct guest_state_element_type *type=
)
> +{
> +    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
> +        (*(uint64_t *)(element->value) & ~(type->mask))) {
> +        print_element(element, gsr);
> +        printf("L1 can't set reserved bits (allowed mask: 0x%08lx)\n",
> +               type->mask);
> +        return true;
> +    }
> +    return false;
> +}
> =20
>  static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>                                               SpaprMachineState *spapr,
> @@ -1108,6 +1240,139 @@ static target_ulong h_guest_create_vcpu(PowerPCCP=
U *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
> +                                 uint64_t vcpuid,
> +                                 struct guest_state_request *gsr)
> +{
> +    void *ptr;
> +    uint16_t id;
> +    struct guest_state_element *element;
> +    struct guest_state_element_type *type;
> +    int64_t lenleft, num_elements;
> +
> +    lenleft =3D gsr->len;
> +
> +    if (!guest_state_request_check(gsr)) {
> +        return H_P3;
> +    }
> +
> +    num_elements =3D be32_to_cpu(gsr->gsb->num_elements);
> +    element =3D gsr->gsb->elements;
> +    /* Process the elements */
> +    while (num_elements) {
> +        type =3D NULL;
> +        /* Debug print before doing anything */
> +        if (false) {
> +            print_element(element, gsr);
> +        }
> +
> +        id =3D be16_to_cpu(element->id);
> +        if (id =3D=3D GSB_HV_VCPU_IGNORED_ID) {
> +            goto next_element;
> +        }
> +
> +        type =3D guest_state_element_type_find(id);
> +        assert(type);
> +
> +        /* Get pointer to guest data to get/set */
> +        if (type->location && type->copy) {
> +            ptr =3D type->location(guest, vcpuid);
> +            assert(ptr);
> +            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
> +                return H_INVALID_ELEMENT_VALUE;
> +            }
> +            type->copy(ptr + type->offset, element->value,
> +                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : fal=
se);
> +        }
> +
> +next_element:
> +        element =3D guest_state_element_next(element, &lenleft, &num_ele=
ments);
> +    }
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong map_and_getset_state(PowerPCCPU *cpu,
> +                                         SpaprMachineStateNestedGuest *g=
uest,
> +                                         uint64_t vcpuid,
> +                                         struct guest_state_request *gsr=
)
> +{
> +    target_ulong rc;
> +    int64_t lenleft, len;
> +    bool is_write;
> +
> +    assert(gsr->len < (1024 * 1024)); /* sanity check */

Use a #define for this, make sure guest can't crash host.
> +
> +    lenleft =3D len =3D gsr->len;

Why lenleft? Can't you just check gsr->len like you do gsr->gsb?

> +    gsr->gsb =3D address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&=
len,
> +                                 false, MEMTXATTRS_UNSPECIFIED);

So it's a read-only memory access to gsr->buf? Even for the set?

> +    if (!gsr->gsb) {
> +        rc =3D H_P3;
> +        goto out1;
> +    }
> +
> +    if (len !=3D lenleft) {
> +        rc =3D H_P3;
> +        goto out1;
> +    }
> +
> +    rc =3D getset_state(guest, vcpuid, gsr);
> +
> +out1:
> +    is_write =3D (rc =3D=3D H_SUCCESS) ? len : 0;
> +    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, false);

I don't think this is right, you want to specify the length of memory
you actually accessed, even if there was some error.

Over-specifying I think would be okay. So I think just use len.


> +    return rc;
> +}
> +
> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
> +                                         SpaprMachineState *spapr,
> +                                         target_ulong *args,
> +                                         bool set)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong lpid =3D args[1];
> +    target_ulong vcpuid =3D args[2];
> +    target_ulong buf =3D args[3];
> +    target_ulong buflen =3D args[4];
> +    struct guest_state_request gsr;
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +    gsr.buf =3D buf;
> +    gsr.len =3D buflen;
> +    gsr.flags =3D 0;

Not a big fan of packaging up some args into a structure,
especially if it's pretty static to a file and no need to be
carried around with some data. Do you even need this gsr
thing?

> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> +        gsr.flags |=3D GUEST_STATE_REQUEST_GUEST_WIDE;
> +    }
> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> +        return H_PARAMETER; /* flag not supported yet */
> +    }
> +
> +    if (set) {
> +        gsr.flags |=3D GUEST_STATE_REQUEST_SET;
> +    }
> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
> +}
> +
> +static target_ulong h_guest_set_state(PowerPCCPU *cpu,
> +                                      SpaprMachineState *spapr,
> +                                      target_ulong opcode,
> +                                      target_ulong *args)
> +{
> +    return h_guest_getset_state(cpu, spapr, args, true);
> +}
> +
> +static target_ulong h_guest_get_state(PowerPCCPU *cpu,
> +                                      SpaprMachineState *spapr,
> +                                      target_ulong opcode,
> +                                      target_ulong *args)
> +{
> +    return h_guest_getset_state(cpu, spapr, args, false);
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -1122,6 +1387,8 @@ void spapr_register_nested_phyp(void)
>      spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
>      spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>      spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
> +    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
> +    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);
>  }
> =20
>  #else
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 3c0d6a486e..eaee624b87 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -206,6 +206,9 @@
>  #define HVMASK_MSR            0xEBFFFFFFFFBFEFFF
>  #define HVMASK_HDEXCR         0x00000000FFFFFFFF
>  #define HVMASK_TB_OFFSET      0x000000FFFFFFFFFF
> +#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000 /* BE in=
 GSB */
> +#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
> +#define GUEST_STATE_REQUEST_SET              0x2
> =20
>  #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>      .id =3D (i),                                     \
> @@ -336,6 +339,25 @@ struct guest_state_element_type {
>      uint64_t mask;
>  };
> =20
> +struct guest_state_element {
> +    uint16_t id;   /* Big Endian */
> +    uint16_t size; /* Big Endian */
> +    uint8_t value[]; /* Big Endian (based on size above) */
> +} QEMU_PACKED;
> +
> +struct guest_state_buffer {
> +    uint32_t num_elements; /* Big Endian */
> +    struct guest_state_element elements[];
> +} QEMU_PACKED;

I think it's probably enough to add one comment saying the PAPR
API numbers are all in BE format. This is actually expected of PAPR
so it goes without saying really, but the nested HV API actually had
some things in guest endian format so it's worth calling out.

Actually maybe single out the nested HV structures as different. I
don't know if the upstream code actually handles endian properly...

Thanks,
Nick

> +
> +/* Actuall buffer plus some metadata about the request */
> +struct guest_state_request {
> +    struct guest_state_buffer *gsb;
> +    int64_t buf;
> +    int64_t len;
> +    uint16_t flags;
> +};
> +
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
>   * New member must be added at the end.


