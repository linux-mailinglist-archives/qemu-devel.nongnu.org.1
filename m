Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E727369B2
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYqk-0003yM-OO; Tue, 20 Jun 2023 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBYqj-0003y3-7O
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBYqh-0005i4-DK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687257874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPuCSOvhUJU87SE3YBXGYNz7uufmGSBT/q5XwZHc7fg=;
 b=BISMnwL8FUU3YaMRzqm5zsEuTf+IzLP7rJ1pK9MFUZqAYj2ozvhAph2fuhPXfVPwPcYbtY
 MB2k/4jSFQdnxnQ39I8ifTXYB4AZBCShZodN8gEIvzaFOlWv4UAZkK2M0c+2+mBldgp7iL
 cExxzc4p0t+ic+P3LNL66EiPVMA+0Yk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-UG7iwfXxNiC7yPjaW4fjPg-1; Tue, 20 Jun 2023 06:44:32 -0400
X-MC-Unique: UG7iwfXxNiC7yPjaW4fjPg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f843e505b1so3120966e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257871; x=1689849871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPuCSOvhUJU87SE3YBXGYNz7uufmGSBT/q5XwZHc7fg=;
 b=NFQGb6E83L2gv+EC1FCZoxL/OMkdffjZzS6FJq7Ifpp3RZBkb+EApIQVTu0gC8TFEt
 k81jGHY0OzSzPgAK7m/AjQPGnOjcIuGvtGJ9udXFuM0HJ8/b2+P4ue9/emKLY8v2nkQu
 ACc+e07bJd9fshMah3qRI1drVc6c4ZFXQbj2HCrMi8tetDM6tbmhZlOxcaHRfziu8g7+
 EbUWcc3J/r/tmBwLJ6VsnbNJBb0HNvBygw36je5/tnKFpufkzuZtAqh+fB01sRSYVhwX
 gIDhiRwg0zqpD4iUlO3BUVEFwxpN2XJfDERVmZMO9yEntLDP27ZxUP1VLdCSaiEe1quT
 0VXw==
X-Gm-Message-State: AC+VfDwVN53xpdMGkOoK5xHl7XpctRqEL0cuThKJbZoHbfpErZI38AYT
 AN5+mc1IwJdVnPsFa3jOaMoN4Bl6LPDtaYS3LcwhySxb7OfLl0OFhRGubySOQMaAWx9SBfp3Fml
 l0FNBVtT4EuVnPjE=
X-Received: by 2002:a19:5f18:0:b0:4f8:714e:27a8 with SMTP id
 t24-20020a195f18000000b004f8714e27a8mr2977122lfb.0.1687257871124; 
 Tue, 20 Jun 2023 03:44:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CyvmgXOoUophNCAjfgB4sju/YJWXUTTY2jD+rAQZ7PEqWwWkQLA9NAMJDwgDCLN2tIPGQbQ==
X-Received: by 2002:a19:5f18:0:b0:4f8:714e:27a8 with SMTP id
 t24-20020a195f18000000b004f8714e27a8mr2977112lfb.0.1687257870817; 
 Tue, 20 Jun 2023 03:44:30 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c469300b003f7f475c3bcsm22800442wmo.1.2023.06.20.03.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 03:44:30 -0700 (PDT)
Date: Tue, 20 Jun 2023 06:44:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
Message-ID: <20230620064406-mutt-send-email-mst@kernel.org>
References: <20230620071805.4400-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620071805.4400-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

just noticed a repeated "slot" in the subject btw.


