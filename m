Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2DB782BE5
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 16:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY5v4-0001oj-KB; Mon, 21 Aug 2023 10:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1qY5uz-0001ni-Gy
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 10:30:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1qY5uw-0002PC-Pn
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 10:30:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so9249308a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1692628203; x=1693233003;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItGA9xkRBwkelGH+Z6UOE910TE3BupOe6yihnzOXtFc=;
 b=ZO08ExRDEJEdpgjCi/LFXRMdTbqtbwOT46AkV2VBiRAg9q9V4J1gJ1ZCM7Sxgppd8h
 vx7OfwbvJUxudevYG0+MCheRx8D7HDhiQAwTd5ZJSoW2aBT4OCN2KDMcsSk30BPMsMqt
 XjeAOAAtsf3S0ukKAo1KcUf5wEcWQ4yAVW3Yfebo//FUhul4etZeYAHttKNyiVxh1RDO
 wY8R1bjggXG2qsWis8IaKyGjrAyY+TFG5UAVOoqYT12sREOiK3/tZS7K7KxL0fxSHtGo
 9ZwXUm5kffXGjW1KkdxJQWXZjz2J6HmadUj5a+y9Ek5uuH10vcNux1q10k/OvirLVyUi
 klNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692628203; x=1693233003;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItGA9xkRBwkelGH+Z6UOE910TE3BupOe6yihnzOXtFc=;
 b=Ly2wFo2FL5N8xcsRLdDcCpvjMoZA/sy1SE1Oh2SV4JBdV4d/IO848bg44W33tGVTHr
 Y+ulkvedJKqa7EXiz9wXZRIvKILvkGs42lLomi7D/lM89YZ92vPbj6AQP3jy0d2EGPQD
 25/HbdiFCJ0daJLp/atZU0ZrHCsmRZbyQDU1llRP3UF9Ac6duaOp9nQx+mDYYaH19TLG
 PkiGmLX6n+pLaHN/hAOktOOgEUU6mi1p/PKMmb+Lb1RC376l+pCEvJ92plUGt88beKR6
 8NdmUT9VeuFG9HCrBGrGVm+zOklVceP5cKx2D6QYw1tpGXsvv21IviV+YsioZnpYLVcA
 jIiw==
X-Gm-Message-State: AOJu0YzPeWOxTwUePih1iJAkh90iX1gJ2/RJ3eaYCqKBuRWju3aMBhBI
 FCsUe1Q45xPFwEUdgnNj1G5EVpdQOuMlE+Bc+hZ8lA==
X-Google-Smtp-Source: AGHT+IEWNJzN9RP5BCKZVY1WwlXKOhGwhHhZ084KpGrZIWgoP2XoM536cMjB559D+xFUKkVJ44A/6XGTVhhebhsf7Z0=
X-Received: by 2002:a17:906:28c:b0:99d:fcb7:60db with SMTP id
 12-20020a170906028c00b0099dfcb760dbmr7884270ejf.16.1692628202851; Mon, 21 Aug
 2023 07:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHEcVy6_HUjwvww9WrqeqruYRyEDwq1Tee-tm3mxaQE=w92-HA@mail.gmail.com>
 <ZN37R//1H+rDTzeS@redhat.com>
In-Reply-To: <ZN37R//1H+rDTzeS@redhat.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 21 Aug 2023 16:29:52 +0200
Message-ID: <CAHEcVy6U3pSyMue=SZ8b_JyWurzgj5fN3Htfg8QqS_Ho16Ye4Q@mail.gmail.com>
Subject: Re: about QEMU TLS
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Jinpu Wang <jinpu.wang@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::530;
 envelope-from=yu.zhang@ionos.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Daniel,

sorry for my slow reply! I tested the approach you suggested by the
following way:

On the target server, start a VM in -incoming mode:

qemu-7.1 \
-uuid ${VM_UUID} \
 ...
-object tls-creds-x509,id=3Dtls0,dir=3D${HOME}/qemutls,endpoint=3Dserver \
 ...
-incoming defer \
-qmp unix:${SOCK},server,nowait \
-qmp unix:${SOCK},server,nowait &

Set the migrate parameter and waiting for the incoming VM from source:

echo '{"execute":"qmp_capabilities"}{ "execute":
"migrate-set-parameters", "arguments": { "tls-creds": "tls0" }}' |
sudo nc -U -w 1 ${SOCK}
echo '{"execute":"qmp_capabilities"}{ "execute": "migrate",
"arguments": { "uri": "tcp::8089" }}

in HMP:
(qemu) migrate_set_parameter tls-creds tls0
(qemu) migrate_incoming tcp:[::]:8089

On the source server, start a VM:

qemu-7.1 \
-uuid ${VM_UUID} \
 ...
-object tls-creds-x509,id=3Dtls0,dir=3D${HOME}/qemutls,endpoint=3Dclient \
 ...
-qmp unix:${SOCK},server,nowait \
-qmp unix:${SOCK},server,nowait &

Set the migrate parameter and migrate the VM from source to target:

echo '{"execute":"qmp_capabilities"}{ "execute":
"migrate-set-parameters", "arguments": { "tls-creds": "tls0" }}' |
sudo nc -U -w 1 ${SOCK}
echo '{"execute":"qmp_capabilities"}{ "execute": "migrate",
"arguments": { "uri": "tcp:10.41.19.32:8089" }}

and query the migration after a few seconds:

echo '{"execute":"qmp_capabilities"}{ "execute": "query-migrate" }' |
sudo nc -U -w 1 ${SOCK}

the migrate is completed successfully.

To further migrate the VM from source (the target for the previously
migration), the endpoint must be changed from "server" to "client" by
QMP commands:

echo '{"execute":"qmp_capabilities"}{ "execute": "object-del",
"arguments": { "id": "tls0" }}' | sudo nc -U -w 1 ${SOCK}
echo '{"execute":"qmp_capabilities"}{ "execute": "object-add",
"arguments": { "id": "tls0", "qom-type": "tls-creds-x509", "endpoint":
"client", "dir": "${HOME}/qemutls", "verify-peer": false }}' | sudo nc
-U -w 1 ${SOCK}

which in HMP commands are:

(qemu) object_del tls0
(qemu) object_add tls-creds-x509,id=3Dtls0,dir=3D${HOME}/qemutls,endpoint=
=3Dclient
(qemu) migrate_set_parameter tls-creds tls0
(qemu) migrate tcp:10.41.16.10:8089

So far as I tested, the TLS certificate must be valid for at least one
day. Therefore, the VM migration with an expired TLS certificate can
only be done in one day.

Thank you so much for your kind reply!
Best regards

Yu Zhang @ IONOS Compute Platform

On Thu, Aug 17, 2023 at 12:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, Aug 07, 2023 at 12:07:31AM +0200, Yu Zhang wrote:
> > Hi all,
> >
> > According to qemu docs [1], TLS parameters are specified as an object i=
n
> > the QEMU command line:
> >
> >    -object tls-creds-x509,id=3Did,endpoint=3Dendpoint,dir=3D/path/to/cr=
ed/dir ...
> >
> > of which "endpoint" is a type of "QCryptoTLSCredsEndpoint" and can be
> > either a "server" or a "client".
> >
> > I'd like to know:
> >
> > - When a VM is started with this config, is there a way (e.g. QMP) to
> > change the value of "endpoint"?
> >   If possible, how to do this? or else after the first migration of a V=
M,
> > the VM has "endpoint=3Dserver",
> >   which can't be migrated without stop / start.
>
> Use object_del + object_add to delete the old credentials and
> create new ones.
>
> > - In which case does the QEMU reload its TLS certificate, e.g. when a Q=
EMU
> > VM has been run longer
> >   than the valid period of its TLS certificate?
>
> The certs are loaded at the time the incoming/outgoing migration
> operation is initiated, so they are always fresh.
>
> > - The migration is done by using HMP monitor on both source and target
> > side. Is it possible to do it
> >   by using QMP commands?
>
> Almost everything in HMP has an equivalent QMP command.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

