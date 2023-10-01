Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F37B4986
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 22:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn2cd-0001qQ-2i; Sun, 01 Oct 2023 16:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qn2ca-0001po-Uk
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 16:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qn2cY-00088S-Gz
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 16:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696190453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eA/FVmAT6E49G6+TrmkQqV5QJONee58dnP0i3KF9eqE=;
 b=fjblzoLpoYV93Yn1D9fo8qK3RiC4ZeJSIcwsoE+RnL9ivEFqFfdhX6HTM+8mvD/RBYbwjy
 7JyuOCQOYMQF8MlEiZrIcaXwQKl9OECyavNDfxXBfdlvQBPgDPEXSSqRtvDdaAw3mB2d9t
 iwxklpW/9nQNylXLN/zn/iKt798E5rA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-V0xYS9G9OL-NtgO8jWwhbg-1; Sun, 01 Oct 2023 16:00:52 -0400
X-MC-Unique: V0xYS9G9OL-NtgO8jWwhbg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500a9156daaso21433276e87.0
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 13:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696190450; x=1696795250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA/FVmAT6E49G6+TrmkQqV5QJONee58dnP0i3KF9eqE=;
 b=MdpPPS/Wi7m8bHWia88/gW1IFLogck+ldJkiDGik7TNWJEOkAZdCGWUdJgX9gfgAqV
 m8LcfByGYX9LbJk2tFpJLybMBefTOH5WR4f+5nqy4ID7aaYF/YWWibq1TgpVW67nVi9S
 3RAU9DwIwbkSjwoEv+ez63jJM2IQPKz7nWWxPwdDIG6o/eFjQsFJ42Yo3GkbwQpiHJna
 eXJ6N6oTmUHS88NVV/mTwTDRQXZ8mTxXCnE46NJEtTrKsM1FT0EyTmgUwrdk17cMdV8A
 wQKA3oMzhF7Is8lbNvZnbqT55ugYEdNz28TVY8DFLcuFNCcscKcwBIQtQWVTG2hPxjhr
 2VfQ==
X-Gm-Message-State: AOJu0YwqXODMyoVLAxcHVfzidKpeGddiHdQiCOYwDzz7ljyZsgz1hx2y
 LnlYQD3vGi2ZZAhtVo77q42Q9D8j6dGdmJqpYKDtDzSUrlTm/Z+VDkHskzofDFVyWTuO0HfHV0h
 GZ8VhbJa9JkXrSiA=
X-Received: by 2002:a05:6512:449:b0:500:b5db:990c with SMTP id
 y9-20020a056512044900b00500b5db990cmr7601102lfk.57.1696190450729; 
 Sun, 01 Oct 2023 13:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7W3NLU5jpAgT/3lG2RhCU1t/ZbeDTgq5Tx4TJST0LEOQgePdskn7dhVNZ5YQuEU6UEcsj+g==
X-Received: by 2002:a05:6512:449:b0:500:b5db:990c with SMTP id
 y9-20020a056512044900b00500b5db990cmr7601089lfk.57.1696190450391; 
 Sun, 01 Oct 2023 13:00:50 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 eq25-20020a056512489900b0050307bf2bcdsm4457145lfb.247.2023.10.01.13.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 13:00:49 -0700 (PDT)
Date: Sun, 1 Oct 2023 16:00:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
Message-ID: <20231001160017-mutt-send-email-mst@kernel.org>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
 <20230830045722.611224-3-fengli@smartx.com>
 <877cpa85n1.fsf@pond.sub.org>
 <5A2A7F1B-9C9E-4633-AF52-564538DEE61C@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A2A7F1B-9C9E-4633-AF52-564538DEE61C@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Sep 12, 2023 at 04:32:59PM +0800, Li Feng wrote:
>     Please mention in the commit message that error messages improve, and
>     silent errors are now reported.
> 
> Ack.


Still waiting for v4 with the updated commit log.

-- 
MST


