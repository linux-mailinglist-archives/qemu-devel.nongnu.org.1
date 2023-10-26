Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 636837D8168
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:59:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvy3e-0007uB-BI; Thu, 26 Oct 2023 06:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvy3b-0007ta-Lt
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvy3W-0006JF-Tp
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698317856;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oc+ch1Ml/yULSTa9Js6u428tBiLtzB0RoF1wSH5FYAA=;
 b=hQ/TtIfrxYeq1H30Z20NnSA0XTvDrrtOdQPGHzySV5p2KOVM2MsWJWApe1its5jG35FfOQ
 PryggiWBQrhnveYa4hgK3d+js4PQp4gg6+Jkx8QPeUYcHnYtLBqp+1okw0tQ3n3KWLt+DU
 1Km/4kJY2y2A5Yz7imwVyrEB5kfOSBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-T_WOkDKnOSeXb_rzHyxYwA-1; Thu, 26 Oct 2023 06:57:35 -0400
X-MC-Unique: T_WOkDKnOSeXb_rzHyxYwA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402cd372b8bso6134145e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698317854; x=1698922654;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oc+ch1Ml/yULSTa9Js6u428tBiLtzB0RoF1wSH5FYAA=;
 b=oH0wg6AkkzkUG8qTnF347xNbxPeI0xFiCl6Ua0109z5MFsy4gozq7Dx0/IaU5sSQFb
 2RO7SciJVIwW+LM3fvnilItRtHPLBwkvLB+XvZPAQZxohfAgVX24wmAYtAj7xhXrjcXh
 0j0eswHYTpj5ZsrvBlwniSLEj3MFxNPVTlp6Z9FOiQw6neE+OgUJz73ggeCrGKo2sb1v
 0+XDqx2nzsERlC9oQk4df5MKHyan6VGsDWDaIDf0Gno5Ix/hEk1P+7KjY1dNHG3HRr16
 G6Sbo7pMI5PRlPZFQL8t623EPvdYR9zTivYPYaCVP9pb7wbVYk9HTYdL8AIZZYWS0u9x
 oUlw==
X-Gm-Message-State: AOJu0YzrY9S/anafM0zK4yT+zMmWREvXLpDPqPd/Vl3v1tuaA/zADn8a
 sZ/jJSZ1zpthc2vkd71fpJLPNeebi/XvueH8+Dl1OTOHmnaVovSPKfDa20AdqOCKWia57R+bE9I
 /VAZXUT7VqqLIDmg=
X-Received: by 2002:a05:6000:1f91:b0:32d:88f6:ec2f with SMTP id
 bw17-20020a0560001f9100b0032d88f6ec2fmr17740590wrb.60.1698317854457; 
 Thu, 26 Oct 2023 03:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8dSUyQX+oUF4Yh/3WCi1kfl1rr56RBg+ZKANH4r83kRhaeBOu+Kd+06fPCeHY8ciFZI/oFA==
X-Received: by 2002:a05:6000:1f91:b0:32d:88f6:ec2f with SMTP id
 bw17-20020a0560001f9100b0032d88f6ec2fmr17740577wrb.60.1698317854110; 
 Thu, 26 Oct 2023 03:57:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m21-20020a056000181500b003271be8440csm13991634wrh.101.2023.10.26.03.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 03:57:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  "Denis V
 . Lunev" <den@openvz.org>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  "Maciej S . Szmigiero"
 <maciej.szmigiero@oracle.com>,  Fam Zheng <fam@euphon.net>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2 3/3] util/uuid: Remove UUID_FMT_LEN
In-Reply-To: <20231026070636.1165037-4-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Thu, 26 Oct 2023 09:06:36 +0200")
References: <20231026070636.1165037-1-clg@redhat.com>
 <20231026070636.1165037-4-clg@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 26 Oct 2023 12:57:32 +0200
Message-ID: <87r0lhejmr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> Dangerous and now unused.
>
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


