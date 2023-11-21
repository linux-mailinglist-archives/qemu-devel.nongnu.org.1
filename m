Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E97F248E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:16:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HFS-00056P-RQ; Mon, 20 Nov 2023 22:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HFJ-00055y-Gl
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:16:17 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HFH-00080v-Vh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:16:17 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7ba75345e71so1690496241.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 19:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700536574; x=1701141374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPIo7ouPs2950xyEq+fIaaSm9lXkxbUBGUbAimA0ZP4=;
 b=Hh7PoxEyr1H0LKAifcJXtciWztmlmEEpFXrlGEbDLClqo33cM3kzVsry9oGTl4UNPa
 seci3lmx5Xfz4b7jYsqMgqds4kMIc47yObuU3wmJYnHV1PSCtogPlYbOFcv5C9POE+2k
 BBvXLkxaXLgU7qPslHRiWuO9IxXeGqOmTmJeJ+OZyVYHy/18L4N9bkdigwd5MtIWj1ih
 EQF/PbckVaR74g9zYgvDNBphVFui0mriYCkvVdjUEgfCRZVpkvuDfd7wCkrgsHcKdJXd
 eaYGprQz9WRelTzw3jnNmC4KpGh6tkkjyTUNPoJlq72u2bjyuhzFnyCTHNI9fNmSG4cw
 hBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700536574; x=1701141374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPIo7ouPs2950xyEq+fIaaSm9lXkxbUBGUbAimA0ZP4=;
 b=W872rwZryBABzPkUcrGoxWs9gFw5boK43gRGDstB/2ttCoWauTSO4/+w5H3lbyOotu
 +D2ZQeqGlRDYEnS5+dCrf6hfmpOZuvATfqXsoCM1inrluWoJfCrlGc8+yrsW2ctAK37V
 5XJM5X6EOIOt/R8FzLOhYhdqRCoqnc8GrGANPN4v74Brg7woAAzTNw06LFhN+fiK58vB
 rchADCTwMVZQzCZQRbhA7Fm6QpWP1MFsOcSUjpqahuZN5Aax2tSoVRp64NLFCOugnNIq
 M2Ok/aBxGF/B/TMglYhKzbYKel140DYakOqTiZOs3BAmXwAdnpgoGC2PqTyiv55ZX7BS
 lwTA==
X-Gm-Message-State: AOJu0YxVrsne0WkWDHU9lAYlTuw85zGhB1mO20e468moLksG1YTIDj1X
 NIWKWwlWHS80XGlf5q9mEWY6lYip3rJAWx8VavA=
X-Google-Smtp-Source: AGHT+IE7oRcff3lx8Lke/OFEWVMuerHSXJaIUoeBcf+p8u3rTyqHSatrNqj1417eiGf78eizgjUQjHk7S0Ulg75mZrc=
X-Received: by 2002:a05:6102:151f:b0:460:5a82:fc5b with SMTP id
 f31-20020a056102151f00b004605a82fc5bmr5149331vsv.5.1700536574051; Mon, 20 Nov
 2023 19:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-6-thuth@redhat.com>
In-Reply-To: <20231117114457.177308-6-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Nov 2023 13:15:47 +1000
Message-ID: <CAKmqyKPTM5bmQpFCMjn+KZhVV5JdUC29fEmGY08UkLesWoYm9Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] qom/object: Limit type names to alphanumerical and
 some few special characters
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Nov 17, 2023 at 9:46=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> QOM names currently don't have any enforced naming rules. This
> can be problematic, e.g. when they are used on the command line
> for the "-device" option (where the comma is used to separate
> properties). To avoid that such problematic type names come in
> again, let's restrict the set of acceptable characters during the
> type registration.
>
> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
> names should begin with a letter, and contain only ASCII letters,
> digits, hyphen, and underscore. However, we already have so many
> pre-existing types like:
>
>     486-x86_64-cpu
>     cfi.pflash01
>     power5+_v2.1-spapr-cpu-core
>     virt-2.6-machine
>     pc-i440fx-3.0-machine
>
> ... so that we have to allow "." and "+" for now, too. While the
> dot is used in a lot of places, the "+" can fortunately be limited
> to two classes of legacy names ("power" and "Sun-UltraSparc" CPUs).
>
> We also cannot enforce the rule that names must start with a letter
> yet, since there are lot of types that start with a digit. Still,
> at least limiting the first characters to the alphanumerical range
> should be way better than nothing.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  qom/object.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/qom/object.c b/qom/object.c
> index 95c0dc8285..654e1afaf2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -138,9 +138,50 @@ static TypeImpl *type_new(const TypeInfo *info)
>      return ti;
>  }
>
> +static bool type_name_is_valid(const char *name)
> +{
> +    const int slen =3D strlen(name);
> +    int plen;
> +
> +    g_assert(slen > 1);
> +
> +    /*
> +     * Ideally, the name should start with a letter - however, we've got
> +     * too many names starting with a digit already, so allow digits her=
e,
> +     * too (except '0' which is not used yet)
> +     */
> +    if (!g_ascii_isalnum(name[0]) || name[0] =3D=3D '0') {
> +        return false;
> +    }
> +
> +    plen =3D strspn(name, "abcdefghijklmnopqrstuvwxyz"
> +                        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +                        "0123456789-_.");
> +
> +    /* Allow some legacy names with '+' in it for compatibility reasons =
*/
> +    if (name[plen] =3D=3D '+') {
> +        if (plen =3D=3D 6 && g_str_has_prefix(name, "power")) {
> +            /* Allow "power5+" and "power7+" CPU names*/
> +            return true;
> +        }
> +        if (plen >=3D 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) =
{
> +            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
> +            return true;
> +        }
> +    }
> +
> +    return plen =3D=3D slen;
> +}
> +
>  static TypeImpl *type_register_internal(const TypeInfo *info)
>  {
>      TypeImpl *ti;
> +
> +    if (!type_name_is_valid(info->name)) {
> +        fprintf(stderr, "Registering '%s' with illegal type name\n", inf=
o->name);
> +        abort();
> +    }
> +
>      ti =3D type_new(info);
>
>      type_table_add(ti);
> --
> 2.42.0
>
>

