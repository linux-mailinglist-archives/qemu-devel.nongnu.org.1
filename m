Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE282A875
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:37:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpd8-0002vW-4Z; Thu, 11 Jan 2024 02:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpd5-0002rC-3b
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpcp-0006KY-Md
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704958634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A1jUOO6uje0SB47QneTCvW8z742zAfLrE5Mu8xPz3+w=;
 b=itVNCYk3rO6U0qCWIcb6TtBYQYzvIKI1zq2/83LaFwj5lmtwdPiyToISTvAlJ5gsH4CeQf
 CgSB5Y6KsI+1Zji6YyONqLTzMnIbJKFqX6iFYvzcd1ATm5rYtFktedxelSaKsgOhLW1hrL
 pkHuN1WPxT0a8fMlsjb1WsiV52qrYDI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-HSZeB4A-NoS8f2_oGYWLGw-1; Thu, 11 Jan 2024 02:37:13 -0500
X-MC-Unique: HSZeB4A-NoS8f2_oGYWLGw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9b6701404so4689435b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704958632; x=1705563432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1jUOO6uje0SB47QneTCvW8z742zAfLrE5Mu8xPz3+w=;
 b=TcxPkcV83AXKJjmwZFz6Gt6N2YC+OqPlUGGDfTroDiMVlkXlB/qLfhV9tOnCUPjMcc
 cVDuIuCqWz9xBwf2NG8vh/8Y8Ad9pu6C8vd+xFXA00B4hf9ZcB7tmO7PfHUZb+Gqdbu+
 SAieJ4YeVeXev3UoSrq3EIexM9qbIj7Po4ySTL1T8DKZXGU+sc0d93+mLllYOWGDu4wD
 n+abOIdTrX3wKeDSORN8kRC4wTdUU6yF5VGfQpimlwOt8JU1IJKKlD2VszIJNMt1N+oT
 OVMeBMOyesAHJW5dMwxspOa2xCTP9xEuqgy2tP66wqdvddDIQYmB0AgKZkInGJamZlkK
 xkgQ==
X-Gm-Message-State: AOJu0YwupQLmhe2ROIi3xkuyvV0eEFepzQDa6kiOw+RPiCE4PM1Q5iPx
 BtUdTREAjhOsuzS+r4aHa43nPmPPkNV8+IKqCaZxs80L8eawVT6dDy22t/Fr5ME8RYqQTAFhv0x
 kIF6y9Yvl+jjTR4mbmRyzIsdXRv71N2R/j5SEa2g=
X-Received: by 2002:a05:6a00:3a28:b0:6d9:9613:cb9e with SMTP id
 fj40-20020a056a003a2800b006d99613cb9emr1041909pfb.29.1704958632369; 
 Wed, 10 Jan 2024 23:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjwpAJsc9OLSqr2PDaFOr4xoCBBXukqOnFsX4SSMENgxfFbVQvTg+qLbilVrEKYxlMfclgXA6YRWOFdcLIyuw=
X-Received: by 2002:a05:6a00:3a28:b0:6d9:9613:cb9e with SMTP id
 fj40-20020a056a003a2800b006d99613cb9emr1041899pfb.29.1704958632116; Wed, 10
 Jan 2024 23:37:12 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-9-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-9-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 15:37:01 +0800
Message-ID: <CACGkMEuF2xVX=fdv5Jq1bJmoMq3wUAJA9tgNSk=n6aHg-=gHcw@mail.gmail.com>
Subject: Re: [PATCH 08/40] vdpa: add back vhost_vdpa_net_first_nc_vdpa
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Dec 8, 2023 at 2:52=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Previous commits had it removed. Now adding it back because
> this function will be needed by next patches.

Need some description to explain why. Because it should not be needed
as we have a "parent" structure now, anything that is common could be
stored there?

Thanks


