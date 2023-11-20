Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B717D7F0EE6
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 10:21:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r50Sj-0000ce-8O; Mon, 20 Nov 2023 04:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r50SU-0000c2-OG
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r50SS-0008E8-KR
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700472042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDm9IqULRf0m3dWb6WuxNjr3pvTiRm0G2fDTz2MbOkw=;
 b=MI5JR6nDfPc8PyutBScPXlqVRimaxHUXfScSNEEpp7hVo4b72ccuSs4jHgFtOsvVWRh34u
 1VA2bDuqANKYh7dcuxBM6nJoG9ExHzkimThAE/vFsyayMlS3+XEedoPoq70TR4p64tEbg2
 +b4c8tssN63Sp+JZFFPc+5nn7Xr1OJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-j57qNIoBPhmdHIwLjO0FUg-1; Mon, 20 Nov 2023 04:20:39 -0500
X-MC-Unique: j57qNIoBPhmdHIwLjO0FUg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4090fa518bbso11075375e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 01:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700472038; x=1701076838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDm9IqULRf0m3dWb6WuxNjr3pvTiRm0G2fDTz2MbOkw=;
 b=iOQkVHjrquAsZ2RzJJWcDdhqSlW56/fa46CC/EfCzu8FecVeFprpbFopu6x6i/p1Rb
 9EvpaXWPecyTU22kSGsLiCxPwjQAJAPWa4vY81w5cAW8MfAUgk5H+CUARO1rvc5FOKB4
 Qmpf9Oaa/w7Qw7DW29hOpKuolZrGJug1IpCz84m+/BsO8i43FFPBoFeIIQjUbsbEiR5A
 /OJP6OWQB2xwx9yReenhsRoRE7znE3At/m0dz9q7xto77ts5lING4V8QfOTrmtjqrAaV
 eF2eNGPnnL/aIeDEsTY0Vk2A2wPSmBlvdRhAXQfBt+8RB4SaFCPBOi2SO2ReGt23+TC2
 IxzQ==
X-Gm-Message-State: AOJu0Yy7hSq+NvLdXkS0SkbJnWZgfZonANCkftsWWl1bPdCbIRLefRU0
 M6bvNHgRtSqoNmXQAiMxmcCKFAP8D5wkT0z+LV/fLrdGWcis6daCvHlW/94+yOc6rzZQ8wkjMAw
 9GukgZWH0IwpjOmg=
X-Received: by 2002:a05:600c:4e92:b0:405:4daa:6e3d with SMTP id
 f18-20020a05600c4e9200b004054daa6e3dmr5608219wmq.39.1700472038531; 
 Mon, 20 Nov 2023 01:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtfZHYVA5vrM/+y1v1JDh2Lq9n4ZPgc4X0im2AMeStXuIktfv4d/TLeiqzusfDhl2ZRUV0Lw==
X-Received: by 2002:a05:600c:4e92:b0:405:4daa:6e3d with SMTP id
 f18-20020a05600c4e9200b004054daa6e3dmr5608207wmq.39.1700472038201; 
 Mon, 20 Nov 2023 01:20:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:626e:8b7b:4d17:fb61:4be1])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b003fee567235bsm17394498wmo.1.2023.11.20.01.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 01:20:37 -0800 (PST)
Date: Mon, 20 Nov 2023 04:20:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio: Refactor vhost input stub
Message-ID: <20231120041944-mutt-send-email-mst@kernel.org>
References: <20231120043721.50555-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Nov 20, 2023 at 12:37:17PM +0800, Leo Yan wrote:
> This series is to refactor vhost stub vhost-user-input.

I tagged this. Given we are in freeze, this will me merged
after the release. To help make sure I don't lose this
please ping me after the release. Thanks!


