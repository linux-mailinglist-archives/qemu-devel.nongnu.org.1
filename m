Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AA73587F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEtm-0000X1-BN; Mon, 19 Jun 2023 09:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEtf-0000WT-U2
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:26:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEtd-0007yE-Sl
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:26:19 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a1d539ffaso6641923a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687181176; x=1689773176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xoozm2wdhr6p4GLAFgOFoBqhwe2ZAaeUEnD5rTWcTEk=;
 b=x2/d0X1q47Rw4WO4x4iELJo5Vl1QTdkEgBkj1j9MMeRwNJJzPCpRbs5nIakX7mrCdu
 KZifC3zV15FHg/ij9owm8c9sAco9wRi9xeAvmstPlisKW6EYfZMFjbQNkHW1ZWNlcfqI
 nvTvDACoGgZL46ZVc5Fq/zJrkIF4D12KnJSrwd14SJiNejwOcJv4K8y8xWiCiUn+BRjy
 uRLfsgcW/hBUafnYqjqrO71JVuOhIp3FChs+G6jQCzh7H/15ug4mw5qGglQkVsksNZT+
 TAI6WOnVF7Fbjfrb25eQp5Lbv2oXSLvUlDE4o8GSYuEflnHYzZb8ZLSkQfo+KeMtv1Hp
 /liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687181176; x=1689773176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xoozm2wdhr6p4GLAFgOFoBqhwe2ZAaeUEnD5rTWcTEk=;
 b=iOPpJ7P85FDovB3UoVshqWOZOOUvMvGvzvQyxwOzI6kGtvHu5wGVp1eYKIeJOKbB0X
 /9ZLUYJ2tlJc+uJvT+kdGLgWco3/osIwuJdRXqFuNPN4yRZAqXukzKUmCuLqEOBxiarg
 N9PhVPCYfAM+mPHZtf7Po3DR5/HxArMgdfuQbHGSELc7Qz6K9v/keQjkx40UAMAnGq34
 0CgwwRlEUN0chgsCTV6oJaolghrU2Kq2QiB4Hz4SX379/9F7ZHnVvvrx/Hlrn7rouxfu
 LE0OnT7EAr1RMLtQtiuVyWYKUju6pvymvOMkQ4WBnH8oy84CEM2tRiO5s4IfrzVt0an/
 +xMw==
X-Gm-Message-State: AC+VfDwJCV+DbOt1DR5NqTLQnb5OH4iy1gJXhlvmyBhERTAszFjllh3b
 iPZjRAn1NdBVDR/1mgQg8DfXFEKoeAgntXW5jJ0JLg==
X-Google-Smtp-Source: ACHHUZ7zknep0/S3FEaSBQ129ARz3BdpljVityn/xtliHpK6ZML3XDuso5fbmtwjvpxTIPpyfr+3horqFmOQVEj+gzU=
X-Received: by 2002:aa7:c604:0:b0:51a:3dfb:ae1a with SMTP id
 h4-20020aa7c604000000b0051a3dfbae1amr7680958edq.4.1687181176240; Mon, 19 Jun
 2023 06:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <168656283612.26761.9869630057811681568-0@git.sr.ht>
 <168656283612.26761.9869630057811681568-2@git.sr.ht>
In-Reply-To: <168656283612.26761.9869630057811681568-2@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 14:26:04 +0100
Message-ID: <CAFEAcA-M=7DCRSONNFCdMGf_HjLV7V8-_NxL8_HnBXPOhSzuUw@mail.gmail.com>
Subject: Re: [PATCH qemu v2 2/2] tests/tcg/aarch64: Add testcases for IC IVAU
 and dual-mapped code
To: "~jhogberg" <john.hogberg@ericsson.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 12 Jun 2023 at 10:40, ~jhogberg <jhogberg@git.sr.ht> wrote:
>
> From: John H=C3=B6gberg <john.hogberg@ericsson.com>
>
> https://gitlab.com/qemu-project/qemu/-/issues/1034
>
> Signed-off-by: John H=C3=B6gberg <john.hogberg@ericsson.com>

> diff --git a/tests/tcg/aarch64/icivau.c b/tests/tcg/aarch64/icivau.c
> new file mode 100644
> index 0000000000..ff80d3d868
> --- /dev/null
> +++ b/tests/tcg/aarch64/icivau.c
> @@ -0,0 +1,204 @@
> +#include <sys/mman.h>

All new source files must start with a license-and-copyright
comment.

> +#include <sys/stat.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +
> +#define PAYLOAD_SIZE (256)
> +
> +typedef int (*SelfModTestPtr)(char *, const char*, int);
> +typedef int (*CompareTestPtr)(int, int);

Generally in QEMU we prefer to typedef the function type,
not the pointer-to-function type.

> +
> +void flush_icache(const char *exec_data, size_t length)
> +{
> +    size_t dcache_stride, icache_stride, i;
> +    unsigned long ctr_el0;
> +
> +    /*
> +     * Step according to minimum cache sizes, as the cache maintenance
> +     * instructions operate on the cache line of the given address.
> +     *
> +     * We assume that exec_data is properly aligned.
> +     */
> +    __asm__("mrs %0, ctr_el0\n" : "=3Dr"(ctr_el0));
> +    dcache_stride =3D (4 << ((ctr_el0 >> 16) & 0xF));
> +    icache_stride =3D (4 << (ctr_el0 & 0xF));
> +
> +    for (i =3D 0; i < length; i +=3D dcache_stride) {
> +        const char *dc_addr =3D &exec_data[i];
> +        __asm__ ("dc cvau, %x[dc_addr]\n"
> +                 : /* no outputs */
> +                 : [dc_addr] "r"(dc_addr)
> +                 : "memory");
> +    }
> +
> +    __asm__ ("dmb ish\n");

You should probably mark all these asm statements as 'volatile'
to ensure that the compiler doesn't decide it can helpfully
reorder or remove them.

> +
> +    for (i =3D 0; i < length; i +=3D icache_stride) {
> +        const char *ic_addr =3D &exec_data[i];
> +        __asm__ ("ic ivau, %x[ic_addr]\n"
> +                 : /* no outputs */
> +                 : [ic_addr] "r"(ic_addr)
> +                 : "memory");
> +    }
> +
> +    __asm__ ("dmb ish\n"
> +             "isb sy\n");
> +}
> +
> +/*
> + * The unmodified assembly of this function returns 0, it self-modifies =
to
> + * return the value indicated by new_move.
> + */
> +int self_modification_payload(char *rw_data, const char *exec_data,
> +                              int new_move)
> +{
> +    register int result __asm__ ("w0") =3D new_move;

Why use an explicit register variable for this rather than
having the __asm__ return its result via an output ?

> +
> +    __asm__ (/* Get the writable address of __modify_me. */
> +             "sub %x[rw_data], %x[rw_data], %x[exec_data]\n"
> +             "adr %x[exec_data], __modify_me\n"
> +             "add %x[rw_data], %x[rw_data], %x[exec_data]\n"
> +             /* Overwrite the `MOV W0, #0` with the new move. */
> +             "str %w[result], [%x[rw_data]]\n"
> +             /*
> +              * Mark the code as modified.
> +              *
> +              * Note that we align to the nearest 64 bytes in an attempt=
 to put
> +              * the flush sequence in the same cache line as the modifie=
d move.
> +              */

This is a QEMU test case, though, and QEMU doesn't care about
cache lines because we don't model the cache. So why does it
matter ?

> +             ".align 6\n"
> +             "dc cvau, %x[exec_data]\n"
> +             ".align 2\n"
> +             "dmb ish\n"
> +             "ic ivau, %x[exec_data]\n"
> +             "dmb ish\n"
> +             "isb sy\n"
> +             "__modify_me: mov w0, #0x0\n"
> +             : [result] "+r"(result),
> +               [rw_data] "+r"(rw_data),
> +               [exec_data] "+r"(exec_data)
> +             : /* No untouched inputs */
> +             : "memory");
> +
> +    return result;
> +}
> +
> +int self_modification_test(char *rw_data, const char *exec_data)
> +{
> +    SelfModTestPtr copied_ptr =3D (SelfModTestPtr)exec_data;
> +    int i;
> +
> +    /*
> +     * Bluntly assumes that the payload is position-independent and not =
larger
> +     * than PAYLOAD_SIZE.
> +     */
> +    memcpy(rw_data, self_modification_payload, PAYLOAD_SIZE);

Your asm code may be position-independent, but you're copying the
entire function here including the preamble and postamble that the
compiler emits for it, and you don't do anything in the makefile
to ensure that it's going to be position-independent.

> +
> +    /*
> +     * Notify all PEs that the code at exec_data has been altered.
> +     *
> +     * For completeness we could assert that we should fail when this is
> +     * omitted, which works in user mode and on actual hardware as the
> +     * modification won't "take," but doesn't work in system mode as the
> +     * softmmu handles everything for us.
> +     */

There's no guarantee on actual hardware that omitting this
flush will cause the test to fail. The hardware implementation
is permitted to drop stuff from the cache any time it feels
like it, and it might choose to do that right at this point.
So any attempt to test "fails if we don't flush the icache"
would be a flaky test. It would also fail on a hardware
implementation where the icache and dcache are transparently
coherent (which is a permitted implementation; the CTR_EL0
DIC and IDC bits exist to tell software it can happily
skip the cache ops).

System mode QEMU works because we model an implementation
with no caches (which is also permitted architecturally).

> +    flush_icache(exec_data, PAYLOAD_SIZE);
> +
> +    for (i =3D 1; i < 10; i++) {
> +        const int mov_w0_template =3D 0x52800000;
> +
> +        /* MOV W0, i */
> +        if (copied_ptr(rw_data, exec_data, mov_w0_template | (i << 5)) !=
=3D i) {
> +            return 0;
> +        }
> +    }
> +
> +    return 1;
> +}
> +
> +int compare_copied(char *rw_data, const char *exec_data,
> +                   int (*reference_ptr)(int, int))
> +{
> +    CompareTestPtr copied_ptr =3D (CompareTestPtr)exec_data;
> +    int a, b;
> +
> +    memcpy(rw_data, reference_ptr, PAYLOAD_SIZE);
> +    flush_icache(exec_data, PAYLOAD_SIZE);
> +
> +    for (a =3D 1; a < 10; a++) {
> +        for (b =3D 1; b < 10; b++) {
> +            if (copied_ptr(a, b) !=3D reference_ptr(a, b)) {
> +                return 0;
> +            }
> +        }
> +    }
> +
> +    return 1;
> +}
> +
> +int compare_alpha(int a, int b)
> +{
> +    return a + b;
> +}
> +
> +int compare_beta(int a, int b)
> +{
> +    return a - b;
> +}
> +
> +int compare_gamma(int a, int b)
> +{
> +    return a * b;
> +}
> +
> +int compare_delta(int a, int b)
> +{
> +    return a / b;
> +}

I don't understand the purpose of all these functions.
I was expecting the test to be something like
 * write initial code
 * execute it
 * modify it
 * execute again and check we got the changed version

I don't see why we need four "compare" functions to do that.

> +int main(int argc, char **argv)
> +{
> +    const char *shm_name =3D "qemu-test-tcg-aarch64-icivau";
> +    int fd;
> +
> +    fd =3D shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
> +
> +    if (fd < 0) {
> +        return EXIT_FAILURE;
> +    }
> +
> +    /* Unlink early to avoid leaving garbage in case the test crashes. *=
/
> +    shm_unlink(shm_name);
> +
> +    if (ftruncate(fd, PAYLOAD_SIZE) =3D=3D 0) {
> +        const char *exec_data;
> +        char *rw_data;
> +
> +        rw_data =3D mmap(0, PAYLOAD_SIZE, PROT_READ | PROT_WRITE, MAP_SH=
ARED,
> +                       fd, 0);
> +        exec_data =3D mmap(0, PAYLOAD_SIZE, PROT_READ | PROT_EXEC, MAP_S=
HARED,
> +                         fd, 0);
> +
> +        if (rw_data && exec_data) {
> +            CompareTestPtr compare_tests[4] =3D {compare_alpha,
> +                                               compare_beta,
> +                                               compare_gamma,
> +                                               compare_delta};
> +            int success, i;
> +
> +            success =3D self_modification_test(rw_data, exec_data);
> +
> +            for (i =3D 0; i < 4; i++) {
> +                success &=3D compare_copied(rw_data, exec_data, compare_=
tests[i]);
> +            }
> +
> +            if (success) {
> +                return EXIT_SUCCESS;
> +            }
> +        }
> +    }
> +
> +    return EXIT_FAILURE;
> +}
> --
> 2.38.5

thanks
-- PMM

