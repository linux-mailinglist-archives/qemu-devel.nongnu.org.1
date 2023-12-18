Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1281736D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:19:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFESd-0006C9-8j; Mon, 18 Dec 2023 09:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFESa-0006BS-Nn
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:19:08 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFESU-0006pW-Hi
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:19:08 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-58d1b767b2bso2113930eaf.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702909140; x=1703513940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Zmv1Q9bEaWYy6C9KyVNJm85iwHY/GOZbU5v+Z4FYUs=;
 b=iRS7SRqqg8hOMIfP7NsnuTKenpSulG8THylTJM3aZ1rYRuUjom9Eg8JRz+BTGa4q5c
 9JvvY0biLtiYLh1wixbIFaI9wQikKKh+ChiK6Xg4jSQvQq79dpzxEmCTlKuS/0gQWzoP
 sclcg2h0o6VSCWKXDVQ0KucK/7SDJiyjBq4YLdakUkAW/KPGx5YRc/gzaWUGmmGyzzwj
 CXL/8S+pXvDP8xmpO7YzWJDDJOT4NVRBs2XTaTtJykLSGqHrB/6eB75hbvdAVgEM/wcX
 tgjnIqehB47Di3dA5r+722pmGgxyyYLg45IL0gkBWMOYNN+Aw0lIGkLC8LyVVgnJyJVx
 VqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702909140; x=1703513940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Zmv1Q9bEaWYy6C9KyVNJm85iwHY/GOZbU5v+Z4FYUs=;
 b=Yg3dR20JwjwVPr6SHTm8KFoQELe/iamoWAmpZfWvpJI29YyMI6aDq/r09UbGRadcGS
 cHsL82xKWZA9RC6Kh8Vxn6yckmZRwaD7e3JpwoOnycPut+VgmTrJqcZ4xrRblDEK4dR3
 k/AegnBidlHj0hV/zNtlHUHo59dhf8HjEMeRg8Nbh0MapHCSJvs/eJOgvz/OCl0msPzY
 U6bSx0ihb9wTko9cBjOxuxQXc8lA8qHitY+3rEFYHqybRAjDVvN9Ljzg4P5wnt60qYzB
 mMIempjyqXX8EET7CLxSqdopuzim0kq8irzn3/JFuXtj29z3yNbfgtFG/OLXBBKtazyU
 YOQw==
X-Gm-Message-State: AOJu0YyqK9BFU/sWDE1LPTfqFaFjCpJKOZz0ZLMmffhPeamjq/uTYD2a
 l4tZvF3XHrgOYMad9EFC4tzJEnrZ1kXzt8eQqrg=
X-Google-Smtp-Source: AGHT+IF9vJmTlAxbWbnRBU3byCh6Sg9E6fsDO0TF45Bf6Vpft7PHn0fyz8bG305GX2B7KnT228xkZtFMLJ4v7u8ZPNc=
X-Received: by 2002:a4a:3116:0:b0:58d:c6b9:8033 with SMTP id
 k22-20020a4a3116000000b0058dc6b98033mr11516275ooa.2.1702909140509; Mon, 18
 Dec 2023 06:19:00 -0800 (PST)
MIME-Version: 1.0
References: <9447a47d-751c-4913-a60b-8d92f87f2998@univention.de>
 <CAJSP0QX_7NtrxjYMCXNtHZkGLV7nXRZ8RUK7m4-ypcf9-8Pr_Q@mail.gmail.com>
 <e0454916-9ee9-46b8-9699-4225fa06fa63@univention.de>
 <CAJSP0QVkiE_kky47++dHReXbajVeiiJJKcaGfmFHjVjFphK7Yw@mail.gmail.com>
 <4cb8f555-d1ab-4fe6-a1af-943d5ab0c6d8@univention.de>
In-Reply-To: <4cb8f555-d1ab-4fe6-a1af-943d5ab0c6d8@univention.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 18 Dec 2023 09:18:48 -0500
Message-ID: <CAJSP0QVw11EzU=1dUjnUR0xqh+T0tQhDBs-ZR9+Dnr_tqyJPsA@mail.gmail.com>
Subject: Re: "Instant clone" with Qemu?
To: Philipp Hahn <hahn@univention.de>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Mon, 18 Dec 2023 at 02:36, Philipp Hahn <hahn@univention.de> wrote:
> Am 15.12.23 um 16:21 schrieb Stefan Hajnoczi:
> >> Am 05.12.23 um 15:44 schrieb Stefan Hajnoczi:
> >>> On Tue, 5 Dec 2023 at 04:53, Philipp Hahn <hahn@univention.de> wrote:
> >> My main problem currently is cloning the MAC address: As our product i=
s
> >> an operating system the MAC addresses of the involved systems is store=
d
> >> in some databases; while in most cases they are not required, I do not
> >> want to hunt for these in all kind of different locations and change
> >> them to some cloned MAC address.
> >> I already had a look at "Virtual Routing and Forwarding"=C2=B2, which =
allows
> >> me to resue the same MAC addresses in different network bridge
> >> interfaces, but what I did not yet get to work is the "routing" betwee=
n
> >> them. I found some very nice articles=C2=B3=E2=81=B4 on how to do NAT =
with VRF, but
> >> it is not yet working.
> >
> > I'm not knowledgeable about VRF. You could also use -netdev
> > user,hostfwd=3Dtcp::$VM_SSH_NAT_PORT-:22 where VM_SSH_NAT_PORT is a
> > unique port assigned by the script that launches the guest. That way
> > each guest can have the same MAC address and IP address but receive
> > incoming SSH connections.
>
> Good to know, thank you. My problem is that I have to clone multiple VMs
> belonging together, they must be able to communicate with each other
> using their unmodified IP addresses; I only need to connect to one of
> them from the outside; something like a "jump host".

--netdev user,guestfwd=3D redirects outgoing connections from a guest.
That might allow you to remap the IP/port of each VM as necessary.

Stefan

