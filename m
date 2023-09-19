Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E581B7A63F1
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaGr-0000ap-Bj; Tue, 19 Sep 2023 08:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1qiaGn-0000aS-PU; Tue, 19 Sep 2023 08:56:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1qiaGj-0006He-Sm; Tue, 19 Sep 2023 08:56:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31fe3426a61so4638704f8f.1; 
 Tue, 19 Sep 2023 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695128155; x=1695732955; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gQdEU6go+fpU8hDq527sv8/od+0rGYGRemKCnMn+450=;
 b=ZMUkOXN2ANObQAlfNoCxMxhCj15u0m2TLe0eL3/tGiYxM3EeOI3LYIJmdJf5M3QNgn
 fy9it0Opcp+dPNklH+xQhmNIlaVCSC8SkILCrwf0HKQ2ckHo8NEYkuB4Mkbg+gBNg+v4
 XnF48F+GNUzNm3VjukrgSyDPRK3rKty7sk+w4oUzl9QZzdDEauBj2lyXhdQRkCl/Bbg2
 JNDT7d3eWnLqCZJOxiDwvDXfhrsWBzsCO+AfvNFGnMqjcr7Kizc6J7e9wgcWrTufLS/8
 QQ/KuEMKV4NaG3Va4iBrhVpEmnOlnFNKrjLxWECOeIHu9z1akE/onCrIEQTs/d6V0+Bu
 htjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695128155; x=1695732955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gQdEU6go+fpU8hDq527sv8/od+0rGYGRemKCnMn+450=;
 b=PJRBz7ZMLb3/kIG12JKWQuiI+AY0Lk7ZCIyhT5Er28jyUzIxCMDG2GmujSsOn0YT0P
 uuj9Gemy786pLSOoWf6NOf62JRS3jyWkPo6QE/TLNXrvN9+YEgXyjNNXz0/7NuEMTeKp
 4I22Ed/CySikVwh2AW3A+C1iH4/XkbqLVlULLDaEKzMW87WlMlWNFRAfdg1Bt41My+qU
 fukTqRrtIpcuro5m7Bc8bhcP/YUNWDDssU8zWjzXpVZQt7HoHeHRkiZxmug5fJo6JERg
 9lHWMMkpT7Cg2rAsoATDM3au9xDlNC0yMsDK/jP07qd51JSwBDIiud9NzOByVNzisJVW
 mMPA==
X-Gm-Message-State: AOJu0YyvWXqBTmklkou5tjLixjtuS0nyveS1F6FNG3xwyTfhW8sIg4vw
 oSIXD98Cr9MtaiyYjtTYV4alKdasJVHJ2hHZ6bo=
X-Google-Smtp-Source: AGHT+IEMhP/mrDaVtYjN8SpZv7rZPk9iiuAGTODJgcl8aUPZbYDmLXHl4PQOpZ9N3kfwchgnzbXvJ1saCCd8xVKUCRI=
X-Received: by 2002:a5d:678f:0:b0:31c:6697:6947 with SMTP id
 v15-20020a5d678f000000b0031c66976947mr10857660wru.69.1695128154590; Tue, 19
 Sep 2023 05:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-9-clg@kaod.org>
 <660b5c89-d219-1e20-9fa5-1b7c390a2f1b@linux.ibm.com>
 <e5480b29-a1d0-8d6f-54b7-a8957f568ed9@kaod.org>
In-Reply-To: <e5480b29-a1d0-8d6f-54b7-a8957f568ed9@kaod.org>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Tue, 19 Sep 2023 18:25:43 +0530
Message-ID: <CAEuJdmqTUOS13mfxVKnMyoeE6vtLAkReohHn31+cz85ZV0s5pA@mail.gmail.com>
Subject: Re: [PATCH 8/8] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000080d2660605b5c78f"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000080d2660605b5c78f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Sept, 2023, 5:39 pm C=C3=A9dric Le Goater, <clg@kaod.org> wrote:

> On 9/19/23 10:48, Harsh Prateek Bora wrote:
> >
> >
> > On 9/18/23 20:28, C=C3=A9dric Le Goater wrote:
> >> Rename 'name' variable to avoid this warning :
> >>
> >>    ../hw/ppc/spapr_drc.c: In function =E2=80=98prop_get_fdt=E2=80=99:
> >>    ../hw/ppc/spapr_drc.c:344:21: warning: declaration of =E2=80=98name=
=E2=80=99 shadows
> a parameter [-Wshadow=3Dcompatible-local]
> >>      344 |         const char *name =3D NULL;
> >>          |                     ^~~~
> >>    ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
> >>      325 | static void prop_get_fdt(Object *obj, Visitor *v, const cha=
r
> *name,
> >>          |
> ~~~~~~~~~~~~^~~~
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>   hw/ppc/spapr_drc.c | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> >> index 843e318312d3..2b99d3b4b1a6 100644
> >> --- a/hw/ppc/spapr_drc.c
> >> +++ b/hw/ppc/spapr_drc.c
> >> @@ -341,7 +341,7 @@ static void prop_get_fdt(Object *obj, Visitor *v,
> const char *name,
> >>       fdt_depth =3D 0;
> >>       do {
> >> -        const char *name =3D NULL;
> >> +        const char *dt_name =3D NULL;
> >
> > I guess you wanted to use the input arg "name" here without
> re-declaration.
>
> I don't understand. I don't want to use the input arg "name" here.
> It seems useless in this case.
>

Yeh, I realize now. This patch can actually remove the unused arg "name" as
well?

C.
>
> > I do not see "name" being used elsewhere in this routine.
> >
> > regards,
> > Harsh
> >>           const struct fdt_property *prop =3D NULL;
> >>           int prop_len =3D 0, name_len =3D 0;
> >>           uint32_t tag;
> >> @@ -351,8 +351,8 @@ static void prop_get_fdt(Object *obj, Visitor *v,
> const char *name,
> >>           switch (tag) {
> >>           case FDT_BEGIN_NODE:
> >>               fdt_depth++;
> >> -            name =3D fdt_get_name(fdt, fdt_offset, &name_len);
> >> -            if (!visit_start_struct(v, name, NULL, 0, errp)) {
> >> +            dt_name =3D fdt_get_name(fdt, fdt_offset, &name_len);
> >> +            if (!visit_start_struct(v, dt_name, NULL, 0, errp)) {
> >>                   return;
> >>               }
> >>               break;
> >> @@ -369,8 +369,8 @@ static void prop_get_fdt(Object *obj, Visitor *v,
> const char *name,
> >>           case FDT_PROP: {
> >>               int i;
> >>               prop =3D fdt_get_property_by_offset(fdt, fdt_offset,
> &prop_len);
> >> -            name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> >> -            if (!visit_start_list(v, name, NULL, 0, errp)) {
> >> +            dt_name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> >> +            if (!visit_start_list(v, dt_name, NULL, 0, errp)) {
> >>                   return;
> >>               }
> >>               for (i =3D 0; i < prop_len; i++) {
>
>
>

--00000000000080d2660605b5c78f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgMTkgU2VwdCwgMjAyMywgNToz
OSBwbSBDw6lkcmljIExlIEdvYXRlciwgJmx0OzxhIGhyZWY9Im1haWx0bzpjbGdAa2FvZC5vcmci
PmNsZ0BrYW9kLm9yZzwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5PbiA5LzE5LzIzIDEwOjQ4LCBIYXJzaCBQcmF0ZWVr
IEJvcmEgd3JvdGU6PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgT24gOS8xOC8yMyAy
MDoyOCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6PGJyPg0KJmd0OyZndDsgUmVuYW1lICYjMzk7
bmFtZSYjMzk7IHZhcmlhYmxlIHRvIGF2b2lkIHRoaXMgd2FybmluZyA6PGJyPg0KJmd0OyZndDs8
YnI+DQomZ3Q7Jmd0OyDCoMKgIC4uL2h3L3BwYy9zcGFwcl9kcmMuYzogSW4gZnVuY3Rpb24g4oCY
cHJvcF9nZXRfZmR04oCZOjxicj4NCiZndDsmZ3Q7IMKgwqAgLi4vaHcvcHBjL3NwYXByX2RyYy5j
OjM0NDoyMTogd2FybmluZzogZGVjbGFyYXRpb24gb2Yg4oCYbmFtZeKAmSBzaGFkb3dzIGEgcGFy
YW1ldGVyIFstV3NoYWRvdz1jb21wYXRpYmxlLWxvY2FsXTxicj4NCiZndDsmZ3Q7IMKgwqDCoMKg
IDM0NCB8wqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpuYW1lID0gTlVMTDs8YnI+DQomZ3Q7
Jmd0OyDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF5+fn48YnI+DQomZ3Q7Jmd0OyDCoMKgIC4uL2h3L3BwYy9zcGFwcl9kcmMuYzozMjU6
NjM6IG5vdGU6IHNoYWRvd2VkIGRlY2xhcmF0aW9uIGlzIGhlcmU8YnI+DQomZ3Q7Jmd0OyDCoMKg
wqDCoCAzMjUgfCBzdGF0aWMgdm9pZCBwcm9wX2dldF9mZHQoT2JqZWN0ICpvYmosIFZpc2l0b3Ig
KnYsIGNvbnN0IGNoYXIgKm5hbWUsPGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB+fn5+fn5+fn5+fn5efn5+
PGJyPg0KJmd0OyZndDs8YnI+DQomZ3Q7Jmd0OyBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdv
YXRlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNsZ0BrYW9kLm9yZyIgdGFyZ2V0PSJfYmxhbmsiIHJl
bD0ibm9yZWZlcnJlciI+Y2xnQGthb2Qub3JnPC9hPiZndDs8YnI+DQomZ3Q7Jmd0OyAtLS08YnI+
DQomZ3Q7Jmd0OyDCoCBody9wcGMvc3BhcHJfZHJjLmMgfCAxMCArKysrKy0tLS0tPGJyPg0KJmd0
OyZndDsgwqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSk8
YnI+DQomZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7IGRpZmYgLS1naXQgYS9ody9wcGMvc3BhcHJfZHJj
LmMgYi9ody9wcGMvc3BhcHJfZHJjLmM8YnI+DQomZ3Q7Jmd0OyBpbmRleCA4NDNlMzE4MzEyZDMu
LjJiOTlkM2I0YjFhNiAxMDA2NDQ8YnI+DQomZ3Q7Jmd0OyAtLS0gYS9ody9wcGMvc3BhcHJfZHJj
LmM8YnI+DQomZ3Q7Jmd0OyArKysgYi9ody9wcGMvc3BhcHJfZHJjLmM8YnI+DQomZ3Q7Jmd0OyBA
QCAtMzQxLDcgKzM0MSw3IEBAIHN0YXRpYyB2b2lkIHByb3BfZ2V0X2ZkdChPYmplY3QgKm9iaiwg
VmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSw8YnI+DQomZ3Q7Jmd0OyDCoMKgwqDCoMKgIGZk
dF9kZXB0aCA9IDA7PGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoCBkbyB7PGJyPg0KJmd0OyZndDsg
LcKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm5hbWUgPSBOVUxMOzxicj4NCiZndDsmZ3Q7ICvC
oMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpkdF9uYW1lID0gTlVMTDs8YnI+DQomZ3Q7IDxicj4N
CiZndDsgSSBndWVzcyB5b3Ugd2FudGVkIHRvIHVzZSB0aGUgaW5wdXQgYXJnICZxdW90O25hbWUm
cXVvdDsgaGVyZSB3aXRob3V0IHJlLWRlY2xhcmF0aW9uLiA8YnI+DQo8YnI+DQpJIGRvbiYjMzk7
dCB1bmRlcnN0YW5kLiBJIGRvbiYjMzk7dCB3YW50IHRvIHVzZSB0aGUgaW5wdXQgYXJnICZxdW90
O25hbWUmcXVvdDsgaGVyZS48YnI+DQpJdCBzZWVtcyB1c2VsZXNzIGluIHRoaXMgY2FzZS48YnI+
PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBk
aXI9ImF1dG8iPlllaCwgSSByZWFsaXplIG5vdy4gVGhpcyBwYXRjaCBjYW4gYWN0dWFsbHkgcmVt
b3ZlIHRoZSB1bnVzZWQgYXJnICZxdW90O25hbWUmcXVvdDsgYXMgd2VsbD/CoDwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9ImdtYWlsX3F1
b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCkMuPGJy
Pg0KPGJyPg0KJmd0OyBJIGRvIG5vdCBzZWUgJnF1b3Q7bmFtZSZxdW90OyBiZWluZyB1c2VkIGVs
c2V3aGVyZSBpbiB0aGlzIHJvdXRpbmUuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IHJlZ2FyZHMsPGJy
Pg0KJmd0OyBIYXJzaDxicj4NCiZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1
Y3QgZmR0X3Byb3BlcnR5ICpwcm9wID0gTlVMTDs8YnI+DQomZ3Q7Jmd0OyDCoMKgwqDCoMKgwqDC
oMKgwqAgaW50IHByb3BfbGVuID0gMCwgbmFtZV9sZW4gPSAwOzxicj4NCiZndDsmZ3Q7IMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50MzJfdCB0YWc7PGJyPg0KJmd0OyZndDsgQEAgLTM1MSw4ICszNTEs
OCBAQCBzdGF0aWMgdm9pZCBwcm9wX2dldF9mZHQoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNv
bnN0IGNoYXIgKm5hbWUsPGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAo
dGFnKSB7PGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgRkRUX0JFR0lOX05P
REU6PGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmR0X2RlcHRoKys7
PGJyPg0KJmd0OyZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZSA9IGZkdF9nZXRfbmFt
ZShmZHQsIGZkdF9vZmZzZXQsICZhbXA7bmFtZV9sZW4pOzxicj4NCiZndDsmZ3Q7IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmICghdmlzaXRfc3RhcnRfc3RydWN0KHYsIG5hbWUsIE5VTEwsIDAs
IGVycnApKSB7PGJyPg0KJmd0OyZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHRfbmFtZSA9
IGZkdF9nZXRfbmFtZShmZHQsIGZkdF9vZmZzZXQsICZhbXA7bmFtZV9sZW4pOzxicj4NCiZndDsm
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghdmlzaXRfc3RhcnRfc3RydWN0KHYsIGR0
X25hbWUsIE5VTEwsIDAsIGVycnApKSB7PGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47PGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfTxicj4NCiZndDsmZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Ozxicj4NCiZndDsmZ3Q7IEBAIC0zNjksOCArMzY5LDggQEAgc3RhdGljIHZvaWQgcHJvcF9nZXRf
ZmR0KE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBjb25zdCBjaGFyICpuYW1lLDxicj4NCiZndDsm
Z3Q7IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEZEVF9QUk9QOiB7PGJyPg0KJmd0OyZndDsgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGk7PGJyPg0KJmd0OyZndDsgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcHJvcCA9IGZkdF9nZXRfcHJvcGVydHlfYnlfb2Zmc2V0KGZkdCwgZmR0
X29mZnNldCwgJmFtcDtwcm9wX2xlbik7PGJyPg0KJmd0OyZndDsgLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbmFtZSA9IGZkdF9zdHJpbmcoZmR0LCBmZHQzMl90b19jcHUocHJvcC0mZ3Q7bmFtZW9m
ZikpOzxicj4NCiZndDsmZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghdmlzaXRfc3Rh
cnRfbGlzdCh2LCBuYW1lLCBOVUxMLCAwLCBlcnJwKSkgezxicj4NCiZndDsmZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGR0X25hbWUgPSBmZHRfc3RyaW5nKGZkdCwgZmR0MzJfdG9fY3B1KHBy
b3AtJmd0O25hbWVvZmYpKTs8YnI+DQomZ3Q7Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIXZpc2l0X3N0YXJ0X2xpc3QodiwgZHRfbmFtZSwgTlVMTCwgMCwgZXJycCkpIHs8YnI+DQom
Z3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjs8YnI+DQom
Z3Q7Jmd0OyDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KJmd0OyZndDsgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSAmbHQ7IHByb3BfbGVuOyBpKyspIHs8
YnI+DQo8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--00000000000080d2660605b5c78f--

