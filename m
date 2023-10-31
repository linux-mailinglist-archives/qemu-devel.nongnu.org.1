Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453D7DCF3B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:31:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpln-0007AL-O5; Tue, 31 Oct 2023 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxplj-00079Z-Vr
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxpli-00084S-6m
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698762657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OZpPuVO4/32cTw3pkafLzYKzgpV4rvvB/L0ZOlTcvE=;
 b=bASMDhCMt0utrZa3f0ljwlD0cw3OIUfX/2HZl0t/zHu3QkWXS9yha57dpPFE7dN1M8725o
 3+z6H0kCJFs/TYU9MbfMHcIM1WHfLqu22losEk8L97Sv1FSjLG2qS4aQywMpGYfRpHdcHz
 qdQR99KyXbFIENvs1fbYusaB87Vif1s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-fkc5sNsXNEiNRE5-z-VjhQ-1; Tue, 31 Oct 2023 10:30:55 -0400
X-MC-Unique: fkc5sNsXNEiNRE5-z-VjhQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c50ef18b04so57049741fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762654; x=1699367454;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5OZpPuVO4/32cTw3pkafLzYKzgpV4rvvB/L0ZOlTcvE=;
 b=ShSP0Xs/gtn5RnvtycccaRwfdTprSjMxURdm7XxIvpLHK3p8lzwqKyD0NptfNZLxok
 OiNoScPkmmxq5KM7Mxks0QBIJnByXn72agBFZrHEZUrUgAwdQMpieeh+QPBbsDwGAgeq
 mX+uApA5ZKK902lpyLJtotlDqwBrklQuGJkeAQZf3dQ9D5285FpRsbi+z/rfSSjhdeSN
 hug2saYBjGeW3eYg1lVcMaJpz+D5y3Lmr5RfbXDrIc8Ju9nyEBqaDPHGRVFCSEfAhSCQ
 AAdP7QB6AfcGKLcGYBZKxKVItqwSztGw5TTil+IDvSPSR8Ax/T2NDZAs0Q/FLNFmHNmF
 5z5w==
X-Gm-Message-State: AOJu0Yx0GosQNuhzfjWq6in632X2Vspg9/Zo1rpU6LqwK2kwWLMoWDQc
 Af+Pvk3yrT3wTAjQlP/zD29UcAJRA9rVBaQlmDgY2K7oqrl9RjjMqBSaEJxGmXlIMHMf8ip1vPs
 D5+4cgOV6Nvjva9A=
X-Received: by 2002:a2e:2c11:0:b0:2c5:6df:8b2c with SMTP id
 s17-20020a2e2c11000000b002c506df8b2cmr10109155ljs.45.1698762654176; 
 Tue, 31 Oct 2023 07:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoySZ+MpzfJUa4udDrXyivTugMKaEbTm5P+FkoO843ma3he8LCplYRlpv3WGlRTtG3sy28lA==
X-Received: by 2002:a2e:2c11:0:b0:2c5:6df:8b2c with SMTP id
 s17-20020a2e2c11000000b002c506df8b2cmr10109139ljs.45.1698762653878; 
 Tue, 31 Oct 2023 07:30:53 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c510400b0040849ce7116sm1900920wms.43.2023.10.31.07.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:30:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 4/5] migration: Change ram_dirty_bitmap_reload()
 retval to bool
In-Reply-To: <20231017202633.296756-5-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Oct 2023 16:26:32 -0400")
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-5-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 15:30:52 +0100
Message-ID: <87edha7tk3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> Now we have a Error** passed into the return path thread stack, which is
> even clearer than an int retval.  Change ram_dirty_bitmap_reload() and the
> callers to use a bool instead to replace errnos.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


