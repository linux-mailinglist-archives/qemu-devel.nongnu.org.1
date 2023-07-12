Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67640750CEB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 17:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJc05-0001vH-WF; Wed, 12 Jul 2023 11:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJc03-0001tL-Sa
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 11:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJc02-0003rT-IJ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 11:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689176608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaNBUbpn1DrgKFFeQA3LFPuMgXL48RFLkI8Oay14Y1g=;
 b=SlR1EgdebcK8GMNntrQi/oZYMF0MSVvp7vfzlX2VEoKkvmQc89RNQgQS04jbjo8Wav0c4z
 vhGDLsJNHw3DiqUbFMGmVoVa2gVtMbmhOu/PREbTEw8dczSnTKv3cDfAgrh/aHr8rnAuOJ
 YzB4FxNDdNIf3py0vHoriVbiRKNYDXI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-GOtaU2FnNbilhHdSBb5aVg-1; Wed, 12 Jul 2023 11:43:27 -0400
X-MC-Unique: GOtaU2FnNbilhHdSBb5aVg-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-440cb3204feso1164524137.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 08:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689176606; x=1691768606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaNBUbpn1DrgKFFeQA3LFPuMgXL48RFLkI8Oay14Y1g=;
 b=ja4X+wZGy7jOfQCPOt0mYH1RC5lMb/jnbCWrt+M5DssaH7EmQ+21eRnyeu8+DbIevh
 KKz0mzo/pLCcX1CAZTmM1e3oz2WMFdOlSKBOeoei2M5MOYJusGgl/SnthZ7yNRmvUYa1
 xhaNryWMgAgBA6Z85gU2DhvdQHqPkNql8WqCs0A8skm3OFxqi/4lx65NYyuSbCBegMve
 PP1QaF8hSXOwLIyIIuEGzgyqmL0SFhqa2V0EhGErC+EtWMdZuHqhgXwxJ0PGQrXDDbiK
 24cZdT2R77FbUMDQZCN40j50iF0cbpZ6GzBOtptPnRI3VOzf3mqiK/YTPNeiXImzRN9G
 gw6A==
X-Gm-Message-State: ABy/qLYRBqu5FbLye4++gsgr9CAD6iSppcFRA2f0uQnhW5QZPwWvzaML
 E7pUb4DZasHan1pY0FZ3o0MRPbRIDilO9W7rvgPpGGaf/CwLQKJlDAeGf/vxmS0PytEEZuOuHgH
 mnLueOsAWX6XA2a9V/7STOczpZHJcTrI=
X-Received: by 2002:a67:cf84:0:b0:443:5ec3:55da with SMTP id
 g4-20020a67cf84000000b004435ec355damr8817413vsm.15.1689176606497; 
 Wed, 12 Jul 2023 08:43:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5doiRYTRXRiHaXYjMH41aFnk4OMTjLRR66UWrdsgpxubx9S77GRIjorYSqr6vvFNiWxIjVf9+W8rHp2g8V64=
X-Received: by 2002:a67:cf84:0:b0:443:5ec3:55da with SMTP id
 g4-20020a67cf84000000b004435ec355damr8817396vsm.15.1689176606253; Wed, 12 Jul
 2023 08:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230712121131.130172-2-pbonzini@redhat.com>
 <9c4b7232-d8ce-fa76-fd85-e800dce89974@redhat.com>
In-Reply-To: <9c4b7232-d8ce-fa76-fd85-e800dce89974@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jul 2023 17:43:14 +0200
Message-ID: <CABgObfbrSjASe2OeTdZ=AM7n-X2Jub4f_k0OgZ+cpFza15gYGA@mail.gmail.com>
Subject: Re: [PATCH v4] kconfig: Add PCIe devices to s390x machines
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 12, 2023 at 2:57=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
> I think the patch is fine for now, but in the long run, I think we should
> make sure to mark PCIe-only devices only with PCIE_DEVICES, as Philippe
> suggested. So PCIe devices will then also not show up any more on targets
> that only provide a plain PCI bus (like hppa, I guess?).

Or even "-M pc", I think.

Paolo


