Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEC7D4E2A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvErl-0005c1-4C; Tue, 24 Oct 2023 06:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEri-0005bG-K8
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvErX-0007dV-UC
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698144130;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrwiItV4bY7DNEKHkOVbh+2vujg6EMz6U0jC/Fq4c78=;
 b=c0u6OYRpZpAFWeddWRnCrnGFYTwBSa1ZkEfaMqE7a5t+iapVJKZ4iMQxrSvijEfZBJRCwF
 jQRjkXFZhTWyNLWL+G7VxpVbHR/hdXB4vuLkaz+voQzFY5ytQvO+0J3YiHp6XPeDpDOxmr
 rhQAfEdmRIEvgg9SsJ7QgeOktuqhVj0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-uEmY0MyfMDOtSRvRkLjEkw-1; Tue, 24 Oct 2023 06:41:59 -0400
X-MC-Unique: uEmY0MyfMDOtSRvRkLjEkw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so36565171fa.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698144118; x=1698748918;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrwiItV4bY7DNEKHkOVbh+2vujg6EMz6U0jC/Fq4c78=;
 b=xNMI8YwnWvpNv010qMOfBy2fPxia6yttUmWaejUi0gOtIK2xI93xfKMfVNvwSSHhtw
 /wuUj8Bv2mfFs7u/X2WUilJ0b4tMiwABk8jWdan5m8Z52zSWBrKE0MXtYv9W/8+JzLmN
 ClaeP7J891tdKMuQWJuwb7TfQN+S8tNktm16JWeB1n/+Ci3JNtNSbl3EnDTGeecuu9IG
 DYNZPgb4Ycu2epKdnYBwVsAnGULIb795GrOpVWMmQig3CeT4NEyyt8h2f7rDw6OLQ+YS
 rKPWIAZDtYenVZSYe80dOY+EQKXutBAV08z/K5N1TApYjRwGgAuKDYFe7eWHMuLUZnkU
 hIMg==
X-Gm-Message-State: AOJu0Yyd9vuVAKv/MjKAhKaQ0i96c9rgj18Cu9tNz6SjYVQikO/58jhY
 fORVm3WPYJZowCSokT8e9IXFQOcPuhJRocwyjMieCnxGXbT1RIVGjdcXfgnIdnUUdV5GpvRj+uz
 gnysEtDA4QMdr/ws=
X-Received: by 2002:a2e:9d02:0:b0:2c5:2133:a9fc with SMTP id
 t2-20020a2e9d02000000b002c52133a9fcmr7920107lji.40.1698144118253; 
 Tue, 24 Oct 2023 03:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsbrsrPJA+rlfR1FmUD4sSg8N5Rmvri86zWREOvr+4l4fZuIqdhIX+wWwL8lHyF/NMFIPIhw==
X-Received: by 2002:a2e:9d02:0:b0:2c5:2133:a9fc with SMTP id
 t2-20020a2e9d02000000b002c52133a9fcmr7920083lji.40.1698144117883; 
 Tue, 24 Oct 2023 03:41:57 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b004063c9f68f2sm11623144wmr.26.2023.10.24.03.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:41:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 5/9] migration: check required subsections are
 loaded, once
In-Reply-To: <20231024084043.2926316-6-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 24 Oct 2023 12:40:39 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-6-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:41:56 +0200
Message-ID: <875y2w1evf.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Check that required subsections have been loaded.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I will let other people to comment on this before merging.

I can see the (pontential problem) that Peter said: We still don't have
enough state.

But I can also see the problem that you are trying to fix: A needed
subsection didn't came.

> @@ -492,7 +521,7 @@ static int vmstate_subsection_load(QEMUFile *f, const=
 VMStateDescription *vmsd,
>              /* it doesn't have a valid subsection name */
>              return 0;
>          }
> -        sub_vmsd =3D vmstate_get_subsection(vmsd->subsections, idstr);
> +        sub_vmsd =3D vmstate_get_subsection(vmsd->subsections, idstr, vi=
sited);
>          if (sub_vmsd =3D=3D NULL) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(looku=
p)");
>              return -ENOENT;

I fully agree that a given subsection shouldn't be loaded more than once.
The part needed for this can get in at any point.



> @@ -509,6 +538,13 @@ static int vmstate_subsection_load(QEMUFile *f, cons=
t VMStateDescription *vmsd,
>          }
>      }
>=20=20
> +    for (i =3D 0; i < n; i++) {
> +        if (!visited[i] && vmstate_section_needed(vmsd->subsections[i], =
opaque)) {
> +            trace_vmstate_subsection_load_bad(vmsd->name, vmsd->subsecti=
ons[i]->name, "(not visited)");
> +            return -ENOENT;
> +        }
> +    }
> +
>      trace_vmstate_subsection_load_good(vmsd->name);
>      return 0;
>  }

This part is the only one where I can see there could be some
discussion.  So I wil wait to see what other people think.

Later, Juan.


