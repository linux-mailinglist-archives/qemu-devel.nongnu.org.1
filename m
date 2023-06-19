Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA2735A09
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:50:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBGCJ-0003kU-Fp; Mon, 19 Jun 2023 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBGC8-0003jh-2y
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBGC6-0000Pc-Ht
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687186165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3S5TiUcuBFRzqNRzjZyxNda7EwrV7u5LIuZh2mspjlA=;
 b=bLyiDJ02MNjgDrSnJD6tKPY3tYhzF8zD+NOf3BwcQ/gp8jEiGKv/N8KSmB5pboJ7VdrYoh
 uXAq1GWE/Twbcs22UcS9x9PYzVyz5ioz/rIZT0wQ2sup7XlLKlqT6nTV1GbakTNKHUeVkl
 yszwZ1AZkD8N5VVd52p0eer8IVdx9O4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218--wcbLNJTP5KDVwwdywgmSQ-1; Mon, 19 Jun 2023 10:49:21 -0400
X-MC-Unique: -wcbLNJTP5KDVwwdywgmSQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3ff1fec3500so2353421cf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687186161; x=1689778161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3S5TiUcuBFRzqNRzjZyxNda7EwrV7u5LIuZh2mspjlA=;
 b=H2Etet/NKTbg5gYlW3/mz2+6pL8jEwQr+ocRnu/SPYMTwWWNVxDsn1tIqiqP0ovJwN
 7Odj8CcOZktpYKltWlpYuLf9nRezSrEJZIoGFt8yTE9q1f0YreSWN3JB2foPe1knRXsB
 WApabwAaTYtoil6BZWlmQNjXNTEna4vMtKWIx6Dwwu/xTqDGp6fT4Bv38E9NXeVeFo4F
 eUbt1EYqEnHbs0vgy5oSWqSo2RMMvzCe/CRHH8i0AUHOq3qMMwTVR7GY06+YiruMl8Wl
 vbz8sJkbVz4OkTdC6pylvjS3IXTqiCvTZPFA0CqFDMo/qzwmoaDL3dsWbwgJAlerFnVG
 EeVw==
X-Gm-Message-State: AC+VfDzxPrHSfxK+Z9v0iuM0PlZdZJ3waRWgf0sEJO3D0bkIIGh2fH7S
 2zjIOCHRyhGRqjxUzzUc2DSYqZz5EuxYN8AB33asAfH9rrS2T09TPs4wsQtJ6nJLGsZfqiL0OId
 V4rBbhr+gcyUgeaI=
X-Received: by 2002:ac8:5f07:0:b0:3f9:c9f3:67b3 with SMTP id
 x7-20020ac85f07000000b003f9c9f367b3mr12348982qta.5.1687186161165; 
 Mon, 19 Jun 2023 07:49:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65Zb9bRfWudiH1YQTnwIOCf4c2YZM0W5tGMXxVa5CQMlEKkv6WIGOy+mVNRzq3r1N5XhLAIA==
X-Received: by 2002:ac8:5f07:0:b0:3f9:c9f3:67b3 with SMTP id
 x7-20020ac85f07000000b003f9c9f367b3mr12348964qta.5.1687186160866; 
 Mon, 19 Jun 2023 07:49:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v12-20020ac8578c000000b003f7fd3ce69fsm10948546qta.59.2023.06.19.07.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:49:20 -0700 (PDT)
Date: Mon, 19 Jun 2023 10:49:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v2] hw: Fix format for comments
Message-ID: <ZJBq78MDBwKzr9S5@x1n>
References: <20230619123404.831803-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619123404.831803-1-shahuang@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 19, 2023 at 08:34:04AM -0400, Shaoqin Huang wrote:
> Simply fix the #vcpus_count to @vcpus_count in CPUArchId comments. Whlie
> at it, reorder the parameters in comments to match the sequence of
> parameters which defined in the CPUArchId.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


