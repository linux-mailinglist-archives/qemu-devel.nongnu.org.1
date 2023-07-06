Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33F74A274
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHS9m-0001Sn-8I; Thu, 06 Jul 2023 12:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHS9g-0001Sa-VP
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHS9f-0007r5-7o
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B20pzgSCy9bRRmFfmCFNU1EXVhpPGrkXs8P+PNa0uiU=;
 b=BwoMVpQ6sT3K9qS44Oq6jr82gOBM4BBaRNU6yPVD3WLC01JYIvkcbOIq2pnw+EvjJQiukj
 gzLVqT45+zDGpc7nsnsvAWdxmRa1KHf/ozPCnu/mril3obOlyK5qURbj3mJffeNrj/sIvH
 U5xTb/gqSrQls0NVS4Ny9Q5Xd12Z+I4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-linjBbFsP16cnyvCLcoCgw-1; Thu, 06 Jul 2023 12:48:28 -0400
X-MC-Unique: linjBbFsP16cnyvCLcoCgw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fbb3c5afdbso898279e87.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662107; x=1691254107;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B20pzgSCy9bRRmFfmCFNU1EXVhpPGrkXs8P+PNa0uiU=;
 b=AbUvi/a1KxHLkRoiCrTfi/F8FCMLjsqP4OOi1YI2vWRQ8H+As9w7xSDpCMiCBSSrJw
 PX7hMIa+GtlruUe4eWgPXaSBE1ipobGpolRDBZilJvymK1l74De5KuOrT9LmsHzOZDom
 0oLmHiLKyKLMFs2H/R1YOu8oqKSeRuhoQSB/0guBTs3Ruzmmu8MI2PT6VpYBvVBeZXL/
 qqa9UC+69cEgVZFuqOoV/NJRibPbraPTMzG4h92vsvW8wgQ6XWdH0Oj5wWxdpTaCR9LB
 O4gXcmDA/jR/JvDuL7PTiAwi8xfwsCPoB23g/yX8J43Y5e7YpZacUlRczk5jlDlOEfZL
 exbg==
X-Gm-Message-State: ABy/qLZOyILiIs9S4B+lbsLSW1KIffIoYd1DQRHEwmuRoFf0EtsWe8P/
 IVQ8scBSwCCKEB/QCas+lzc4MvEyEcrVj8yIElV1wgi6ByxTRXGlZpkExJGy7QJUe/L3BeOD7L4
 b2CnOybyN1GBHiOk=
X-Received: by 2002:a19:501d:0:b0:4f8:6e6e:4100 with SMTP id
 e29-20020a19501d000000b004f86e6e4100mr1772921lfb.52.1688662106866; 
 Thu, 06 Jul 2023 09:48:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEwZNNAMw0NtBAtrx170u/yb58eNGK9ZeL+P2bvqcNtSCBHfcCtRrQQoe0dDEeesNwOuihlSw==
X-Received: by 2002:a19:501d:0:b0:4f8:6e6e:4100 with SMTP id
 e29-20020a19501d000000b004f86e6e4100mr1772907lfb.52.1688662106426; 
 Thu, 06 Jul 2023 09:48:26 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 f18-20020adff992000000b003142e438e8csm2323552wrr.26.2023.07.06.09.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:48:25 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:48:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 marcandre.lureau@redhat.com, stefanha@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230706124347-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> Currently QEMU has to know some details about the back-end to be able
> to setup the guest. While various parts of the setup can be delegated
> to the backend (for example config handling) this is a very piecemeal
> approach.

> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.

The reason we do piecemeal is that these existing pieces can be reused
as others evolve or fall by wayside.

For example, I can think of instances where you want to connect
specifically to e.g. networking backend, and specify it
on command line. Reasons could be many, e.g. for debugging,
or to prevent connecting to wrong device on wrong channel
(kind of like type safety).

What is the reason to have 1 message? startup latency?
How about we allow pipelining several messages then?
Will be easier.


> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> Initial RFC for discussion. I intend to prototype this work with QEMU
> and one of the rust-vmm vhost-user daemons.
> ---
>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user.c      |  8 ++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..85b1b1583a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -275,6 +275,21 @@ Inflight description
>  
>  :queue size: a 16-bit size of virtqueues
>  
> +Backend specifications
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-----------+-------------+------------+------------+
> +| device id | config size |   min_vqs  |   max_vqs  |
> ++-----------+-------------+------------+------------+
> +
> +:device id: a 32-bit value holding the VirtIO device ID
> +
> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
> +
> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> +
> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
> +

looks like a weird set of info.
why would we want # of vqs and not their sizes?
why config size but not config itself?




>  C structure
>  -----------
>  
> @@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserBackendSpecs specs;
>        };
>    } QEMU_PACKED VhostUserMsg;
>  
> @@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>  
>  .. seealso::
>  
> @@ -885,6 +902,13 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
> +
> +Some features are only valid in the presence of other supporting
> +features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
> +backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
> +``VHOST_USER_PROTOCOL_F_STATUS``.
> +
>  
>  Front-end message types
>  -----------------------
> @@ -1440,6 +1464,19 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
>  
> +``VHOST_USER_GET_BACKEND_SPECS``
> +  :id: 41
> +  :request payload: N/A
> +  :reply payload: ``Backend specifications``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_STANDALONE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to
> +  query the back-end for its capabilities. This is intended to remove
> +  the need for the front-end to know ahead of time what the VirtIO
> +  device the backend emulates is.
> +
> +  The reply contains the device id, size of the config space and the
> +  range of VirtQueues the backend supports.
>  
>  Back-end message types
>  ----------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c4e0cbd702..28b021d5d3 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;
> +    uint32_t max_vqs;
> +} VhostUserBackendSpecs;
> +
>  typedef struct {
>      VhostUserRequest request;
>  
> @@ -226,6 +233,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserBackendSpecs specs;
>  } VhostUserPayload;
>  
>  typedef struct VhostUserMsg {
> -- 
> 2.39.2


