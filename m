Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E966F7BCC5B
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMKf-0003MY-JP; Sun, 08 Oct 2023 01:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qpMKd-0003MD-KK
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qpMKc-0006X0-88
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696742877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hr7T1ZkDawWvtjDrdIneKcvzMEjpeZm7SKe5BPaAeio=;
 b=Xh5LiUMYCeAGajGK1rOJ/3zUvqjrCBpEJvz810eZoh8v9IG9V31jY2hTtkPJW+9eArh1gi
 Sk8Jl7MtDN2RAesBg8zbwGPBh5RgQYCZkLvV7UdU1j5E1BUJpEvlnvE5hKgX5Vx3VBjfwC
 nrpQURDNxNaWmlVFqoEk9Geev5EOXQo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-p-Qc9by2NSqyRDpy-bBCBw-1; Sun, 08 Oct 2023 01:27:51 -0400
X-MC-Unique: p-Qc9by2NSqyRDpy-bBCBw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5068bf0b425so1406779e87.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742869; x=1697347669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hr7T1ZkDawWvtjDrdIneKcvzMEjpeZm7SKe5BPaAeio=;
 b=TxoKDOvaFpEdVjsAOSXl5/SpnaOCwh208rwifwPUqsfML0bpiVz4Jcioge1m8q2GOZ
 h9lKCXI2ywBu39/g1LPBiCk1tuLMm1UtX8/4SIYaJ3moDLMPUUpwClM+OG3yXBwGQHI1
 jRuYJNVIWXrbMi9YdhfpTBuCmZEgbf5MGC43FObNcHXL3Ly8jQf/Tgwg0gFvCncuYJGk
 JwFZ4IEzNUjVTE8IcT5aVlWkR2VgVOCYbolRvh14aregLRMhe94GKndxqJvFwjpsC2Ix
 1iL7Aj6IvFbPm+ch+Jcuh5aFhqRbs22DcE3x4IRpAxLqfnP2zMpkO4aiMMT0yBd/afIO
 MHTg==
X-Gm-Message-State: AOJu0Yz7Hww/UqtccqP3GjdYjSK9vBH5S1FCHwJooJgo9+RfAtr4EE/i
 fjGkLlrOZOKFV1pIabq30LNw5o6XMKp3Gwp4/a35tviozhlWybsDVldyM7XKzlI4eTY1KNkC7VZ
 X59WbcZ/FXf4JOOMwuKA/1jv1mtX5pVg=
X-Received: by 2002:a05:6512:39d0:b0:504:51e9:89a2 with SMTP id
 k16-20020a05651239d000b0050451e989a2mr15625757lfu.32.1696742869644; 
 Sat, 07 Oct 2023 22:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRscR506okY7xwG1XImUKUol7kSiOvFx26DTqoqggKCVYoZybrCUD14IvLUIa7G2eL0QbAjoygf7Mvz0cMxPs=
X-Received: by 2002:a05:6512:39d0:b0:504:51e9:89a2 with SMTP id
 k16-20020a05651239d000b0050451e989a2mr15625748lfu.32.1696742869357; Sat, 07
 Oct 2023 22:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231004084939.96349-1-thuth@redhat.com>
 <20231004045724-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231004045724-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:27:38 +0800
Message-ID: <CACGkMEvfUDzDvor6TjcF8-2wbymgNKxvn77gUM8KuiAb5Ndi7g@mail.gmail.com>
Subject: Re: [PATCH] hw/net/vhost_net: Silence compiler warning when compiling
 with -Wshadow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 4, 2023 at 4:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Oct 04, 2023 at 10:49:39AM +0200, Thomas Huth wrote:
> > Rename the innermost local variables to avoid compiler warnings
> > with "-Wshadow".
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> feel free to merge
>
> > ---
> >  hw/net/vhost_net.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 57427a3997..e8e1661646 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -313,8 +313,8 @@ fail:
> >                  /* Queue might not be ready for start */
> >                  continue;
> >              }
> > -            int r =3D vhost_net_set_backend(&net->dev, &file);
> > -            assert(r >=3D 0);
> > +            int ret =3D vhost_net_set_backend(&net->dev, &file);
> > +            assert(ret >=3D 0);
> >          }
> >      }
> >      if (net->nc->info->poll) {
> > @@ -629,8 +629,8 @@ err_start:
> >      if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
> >          file.fd =3D VHOST_FILE_UNBIND;
> >          file.index =3D idx;
> > -        int r =3D vhost_net_set_backend(&net->dev, &file);
> > -        assert(r >=3D 0);
> > +        int ret =3D vhost_net_set_backend(&net->dev, &file);
> > +        assert(ret >=3D 0);
> >      }
> >
> >      vhost_dev_stop(&net->dev, vdev, false);
> > --
> > 2.41.0
>


