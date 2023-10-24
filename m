Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA17D4E30
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:45:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEtr-0007WS-Pn; Tue, 24 Oct 2023 06:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEtp-0007T8-M7
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEtk-0008Dy-KY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698144271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlsGNjXh3MpR+Izorjw+zIj/N4+dRUei2aVGyUN0GXs=;
 b=MbCu9oi2dhyYyhG02lYpIHv5nPq0UmsQWcqJx/JAe5c9Aeaoq9ZnsJOUSeYJww4eO3eSiJ
 xadXHOMA5G81zKQ5j4xPPq//1SOGqIPaeydGvRRJGZBdB2DDtZ0dQpuwIgKgA/aMM8j8Qc
 w2tZfg1zXXGI9QT70/V76mQc39v61GA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-XO6trgzJNpK1rP-kMvdmCg-1; Tue, 24 Oct 2023 06:44:15 -0400
X-MC-Unique: XO6trgzJNpK1rP-kMvdmCg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so23043655e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698144254; x=1698749054;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vlsGNjXh3MpR+Izorjw+zIj/N4+dRUei2aVGyUN0GXs=;
 b=NrJe16F1eejj9Nbnr+vxt8NR1Qv4PAxgeOL9tochiWuv56BRdlTa+7hcounnj8peAq
 kWa8t/xHSvPJ9QX5EUbIDwsbCZDBZ7L3L4ipoLabC5Q/hyI2QK8UoQX86vD7Zb1spUZb
 5MSe1mPz4i33Ce+32s6CbGL9ECbn/m9sp8mMh6075dkVV2I8LpfkGCXfCJbU1QRl+i61
 zN/AYCApL38YSH0zMJulX0XkaDMQ084k7fufietUNqcmuxI8t0gmXGH2n8v7aVb/66fH
 T1ThlUcYaq1PaRCtDdeDgKH73tBuXgtWPNfwCtjGwaI49J+975lyAKUJx0+MNbOoRrj5
 FvcA==
X-Gm-Message-State: AOJu0YyO9eNME5Xn8jeQEl4P6AXPdzMsZINBpvRWAgZ6KIc0ldfpiMNv
 T5J/turdUz+jenvkM4iTt+pTFmjv6VNUzDcWAmlh9udS6TDT+bZaFwSm5Sl9i6V+3PHt9LyulMu
 FGpYSFDt8tJb7gHg=
X-Received: by 2002:a05:600c:3b97:b0:3ff:ca80:eda3 with SMTP id
 n23-20020a05600c3b9700b003ffca80eda3mr9593188wms.10.1698144254249; 
 Tue, 24 Oct 2023 03:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+uuF65Iaa+3tH0rpETru8rmgS5ewJCuFKqx4DjnZkV+0/Air/LN1ae45fO7OmMUWHQG6onQ==
X-Received: by 2002:a05:600c:3b97:b0:3ff:ca80:eda3 with SMTP id
 n23-20020a05600c3b9700b003ffca80eda3mr9593163wms.10.1698144253858; 
 Tue, 24 Oct 2023 03:44:13 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040841e79715sm11838295wmq.27.2023.10.24.03.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:44:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 6/9] migration: check required entries are loaded, once
In-Reply-To: <20231024084043.2926316-7-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 24 Oct 2023 12:40:40 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-7-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:44:12 +0200
Message-ID: <871qdk1ern.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> @@ -2541,6 +2572,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, Migrat=
ionIncomingState *mis)
>                       idstr, instance_id);
>          return -EINVAL;
>      }
> +    if (se->visited) {
> +        error_report("error while loading state for instance 0x%"PRIx32"=
 of"
> +                     " device '%s'", instance_id, idstr);
> +        return -EINVAL;
> +    }

When this is a subsection (always) It would be a good idea to know what
section we are talking about. but not sure how easy is to get that informat=
ion.

Later, Juan.


