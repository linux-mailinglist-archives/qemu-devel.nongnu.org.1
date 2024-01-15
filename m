Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B227E82D69F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:01:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJmU-0002DS-GD; Mon, 15 Jan 2024 05:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPJmI-00028S-Vl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:01:11 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPJmH-00056o-GN
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:01:10 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-429bd0f2768so32200321cf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 02:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705312868; x=1705917668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OZJt1KVM50++f+mWb35ofs7kNhKqZ+G3toafWJnbEk=;
 b=A2yJ7COBWrGTsAXTjbDino72IMCUGrX7aMsiaEyAmeDh5HzZGvdPZZqn4wI8f/UkJt
 UT0QLRManP6f39qSHmtj+s7knwVuI3QUS+cNLuvcWveEBmLy3vKqYSmwTs9vn2/GTd6i
 dDjljqxEpdFgoqar/aK94bpjxYgHVuJndZHvPIBziLEI3oXO0GhE3YHH6tdabH/ifQnf
 ZmirGBaaRxVs/puwJBR3eNrqAQkVIp/X+8AyZW8scO79zK3ZXdJ8nAqoebVBzvBmL4nI
 XzZG0LYiAkzXa8aTLXAmLR24CdzgbSJkM0tFf4vKFUYll8robqGTr4XLZfkWaXqtCoiB
 O+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705312868; x=1705917668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OZJt1KVM50++f+mWb35ofs7kNhKqZ+G3toafWJnbEk=;
 b=cPSFOWdl9luA+v8+4NRpDgLkPDt9W0rr0qGQnESbW+JX0mQPcPvoqr0j7datWpfguY
 UEdCPTtLzX17yeKT6/plot/1sXA9rZ/owviV4JpdyM1nirX1MOH5EwxAfc7scozFXqxO
 34u8STzT9LDTAnuGIav1AFXuUMpA5v4/aIHKwsZK9Vxq4skPx52QPxSL7wkqSooupvxc
 cb6J8CJgMftjT0d3RxWUbYceiHiP2Pj51v5pGcIvbMXcrBGkWCS0wrqciBxLlpUT9cZn
 7J0LSxzOwy9u2i94Y0vtc843lfZWDOQCh0OEeksokmB+H8vNMCS+8TXpkYBUWaPIl8d6
 to/A==
X-Gm-Message-State: AOJu0YzCrZLWHqXf5Bd/gSquswifUdld8A5Ajj4DTd+zg0IbXvCH1DKw
 8CyH1CJq+rIPI7PArlrsVMcnPey56WOs6jaEWj4=
X-Google-Smtp-Source: AGHT+IFGgwJAct4YTr1Jlprnm6jamoEK5TF+PVj2/VxoqhOR57JebWR+EqukAt3NfhM76mMLEtpHXBD86XXZxW6eYTc=
X-Received: by 2002:ac8:5f11:0:b0:429:c4cb:23c9 with SMTP id
 x17-20020ac85f11000000b00429c4cb23c9mr8475909qta.39.1705312868143; Mon, 15
 Jan 2024 02:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20240115095119.654271-1-berrange@redhat.com>
In-Reply-To: <20240115095119.654271-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jan 2024 14:00:55 +0400
Message-ID: <CAJ+F1CJkSX3LFxbMDC2PpCCzCy78u6fuKapGwvudGe-m1mrpDQ@mail.gmail.com>
Subject: Re: [PATCH] ui: reject extended clipboard message if not activated
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>, 
 Markus Frank <m.frank@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jan 15, 2024 at 1:52=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The extended clipboard message protocol requires that the client
> activate the extension by requesting a psuedo encoding. If this
> is not done, then any extended clipboard messages from the client
> should be considered invalid and the client dropped.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> The need for fix was identified as part of investigation for
> CVE-2023-6683. This does NOT, however, fix that CVE as it only
> addresses one of the problem codepaths that can trigger that
> CVE.
>
>  ui/vnc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 4f23a0fa79..3b2c71e653 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2445,6 +2445,11 @@ static int protocol_client_msg(VncState *vs, uint8=
_t *data, size_t len)
>          }
>
>          if (read_s32(data, 4) < 0) {
> +            if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
> +                error_report("vnc: extended clipboard message while disa=
bled");
> +                vnc_client_error(vs);
> +                break;
> +            }
>              if (dlen < 4) {
>                  error_report("vnc: malformed payload (header less than 4=
 bytes)"
>                               " in extended clipboard pseudo-encoding.");
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

