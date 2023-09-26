Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564C7AEE0D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8Lj-0000XH-Sn; Tue, 26 Sep 2023 09:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8Le-0000Wn-AW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:43:34 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8Lc-0007bi-Cz
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:43:34 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5043120ffbcso13433329e87.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695735809; x=1696340609; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E5gaLdbSuUwS3BvHz3PonEa+sVPuj1zzd4P8R2sODd8=;
 b=odHFxwL0i/0t6Ni/Q9iujZZC684chSjROlwnCYFkvEQ1p5Z/7bdBH0W0ZFRES7Aabe
 iGCwxN9D/w0g6DMas9fIMEM/MunRpiOgx60IR6YdSrr4+T5LBTt+Whi/dc6ZHFtEb8G/
 ySDmkNfhDqUt+ZggKbADpEzVTaJSTwSihPqJrK987NwXx8nY23xZwo1pUl3K04rhjHuz
 9TMPSxcX24s0bPY7hwtPc3tErOh60aBK0z2rQTUVNPq+SqGNMJUrqqDpZfcfpA/w7X93
 MLDuAGwsmGmUKEcXicg+XR4uZRe9n2xbOH37wWLa1Y35rV7iUQx5r5LeBbqKgg+4402Y
 aY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695735809; x=1696340609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5gaLdbSuUwS3BvHz3PonEa+sVPuj1zzd4P8R2sODd8=;
 b=XAD4kOywYY/6Y26OsOpgnqyzT2+5kiFKFQzh9loFkdtZ+N12W+87Hgmor2VX1acWP7
 lx52rPt1PLa0rEcZxJxq+zmHxoqgtV+V2ZrgamWZhlLZ+XJFnPe6HHZQJrH3eWGWDHfQ
 XYyky7d+HN/FCot1tKdTn8uNIVQZ4lnC/1nl33CG1uMexRAUmuAndSncC4efN8bkt2bB
 YgbrKlLscHR7wI+CbFvQXQnswhZHUoR3pM5oxxt+l34RUFbwWPioAmJCNQJ0Sw6379y5
 PoYl2qdjSKeORI1KxkgVL5m1PXnJGc+kSLuHXb0tziKHeWPVui103MVWKqcOZsb5oW5w
 srHQ==
X-Gm-Message-State: AOJu0Yye0sXOG2bteMHeBkTjvLO6HLAu6FZqP1KMBBs/B+sbF4LgQhVb
 ZB19G7N+RWrx/RoJYXv3clqqNkCQtPn38/VyUOar2Q==
X-Google-Smtp-Source: AGHT+IEtcN28JqcBWVqKFGcNgk1pmnA1U8JuA27J3JBgiIzKy6rVqj5o0UlsU10Hj3FWxi3AySug7sYIpOBo5mztJJA=
X-Received: by 2002:a19:384b:0:b0:503:3245:6eda with SMTP id
 d11-20020a19384b000000b0050332456edamr7115181lfj.40.1695735809145; Tue, 26
 Sep 2023 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170153.10959-1-viktor@daynix.com>
 <20230915170153.10959-2-viktor@daynix.com>
In-Reply-To: <20230915170153.10959-2-viktor@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 14:43:11 +0100
Message-ID: <CAFEAcA9rsabG1B197mBRXdLXQCa+x6v3Sp=XXE2HSUBNtR448Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] elf2dmp: replace PE export name check with PDB
 name check
To: Viktor Prutyanov <viktor@daynix.com>
Cc: annie.li@oracle.com, akihiko.odaki@daynix.com, kkostiuk@redhat.com, 
 qemu-devel@nongnu.org, yan@daynix.com, viktor.prutyanov@phystech.edu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 15 Sept 2023 at 18:02, Viktor Prutyanov <viktor@daynix.com> wrote:
>
> PE export name check introduced in d399d6b179 isn't reliable enough,
> because a page with the export directory may be not present for some
> reason. On the other hand, elf2dmp retrieves the PDB name in any case.
> It can be also used to check that a PE image is the kernel image. So,
> check PDB name when searching for Windows kernel image.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2165917
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>  contrib/elf2dmp/main.c | 93 +++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 60 deletions(-)

Hi; Coverity points out a bug in this code (CID 1521598):


> -static int pe_get_pdb_symstore_hash(uint64_t base, void *start_addr,
> -        char *hash, struct va_space *vs)
> +static bool pe_check_pdb_name(uint64_t base, void *start_addr,
> +        struct va_space *vs, OMFSignatureRSDS *rsds)
>  {
>      const char sign_rsds[4] = "RSDS";

sign_rsds[] is not NUL-terminated...

>      IMAGE_DEBUG_DIRECTORY debug_dir;
> -    OMFSignatureRSDS rsds;
> -    char *pdb_name;
> -    size_t pdb_name_sz;
> -    size_t i;
> +    char pdb_name[sizeof(PDB_NAME)];
>
>      if (pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
>                  &debug_dir, sizeof(debug_dir), vs)) {
>          eprintf("Failed to get Debug Directory\n");
> -        return 1;
> +        return false;
>      }
>
>      if (debug_dir.Type != IMAGE_DEBUG_TYPE_CODEVIEW) {
> -        return 1;
> +        eprintf("Debug Directory type is not CodeView\n");
> +        return false;
>      }
>
>      if (va_space_rw(vs,
>                  base + debug_dir.AddressOfRawData,
> -                &rsds, sizeof(rsds), 0)) {
> -        return 1;
> +                rsds, sizeof(*rsds), 0)) {
> +        eprintf("Failed to resolve OMFSignatureRSDS\n");
> +        return false;
>      }
>
> -    printf("CodeView signature is \'%.4s\'\n", rsds.Signature);
> -
> -    if (memcmp(&rsds.Signature, sign_rsds, sizeof(sign_rsds))) {
> -        return 1;
> +    if (memcmp(&rsds->Signature, sign_rsds, sizeof(sign_rsds))) {
> +        eprintf("CodeView signature is \'%.4s\', \'%s\' expected\n",
> +                rsds->Signature, sign_rsds);

...but in this printf() we pass sign_rsds to a "%s" format
specifier, which requires NUL termination.

If you want to print a non-NUL-terminated string you need
to do the same thing we do for rsds->Signature, which is
give it a precision which is the correct length so printf
doesn't read off the end (i.e. "%.4s").

thanks
-- PMM

