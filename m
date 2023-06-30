Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6E743951
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBKI-0000hb-5q; Fri, 30 Jun 2023 06:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFBK7-0000ef-Ip
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFBK5-0006st-Vh
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688120751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LPBAMeL1+2oRMK89+JDAlcaJGSm10oErwTbUnX9kC0=;
 b=HoVBFFCDpDZ8Xklf+LTEd7rX2MfO3nO2iUTWaqnCOaWsiacu804x7CXjdvm87UOCQ2p4w/
 i+mDORc8nM+XqNGioiuPK8bCNryh5cXlsIfpTvLrIhGiIGH5FrBQ4a4hEdGifCgEzxVVYu
 xnh/BrjHTrMQZ85JMyeEsNU4JSXRSns=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-eDf3DAbRNTO_AljX67XjKw-1; Fri, 30 Jun 2023 06:25:48 -0400
X-MC-Unique: eDf3DAbRNTO_AljX67XjKw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31273e0507dso960869f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688120747; x=1690712747;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LPBAMeL1+2oRMK89+JDAlcaJGSm10oErwTbUnX9kC0=;
 b=i4TGUWx9pzlHk8UmpYvQr598y+521RMQ3kBoScOGvBNCYVQ0kSPnoxEw+vjfGO5apT
 dApWVRrXvm5U4pPtS6ouychLBOZ0HlHFirZPag2fAKv4M/HXzXgpqOuppsa7UYuvWT6q
 c5MpxBCS0kUKUb4RlykXNez2R7rLHtZwe9tSaByEvApJ0X0aKcv35Y9d8a4GUkTo4of7
 weietVMiqYu9fHMWAHeNHaAenFVarHzlZ990RNIsboz3UWbSsmzrr8yYXAJOFG1nQ+bi
 3Yl7FhlfU1/G9FnkuaCmDAejwb+IOZBA8GjLRIwL/M21bdRXNWIVT5WdrMPWUMJUuYwD
 IK/A==
X-Gm-Message-State: ABy/qLaaahrPWM420JWtx79UhbPJ4w74h/+gm0k5GZAsLfIjNLQrGA0j
 g8LzpclE6SJr5sX835ZAcFAbKNW5fvMsEtcUj9yHGA6n1WMlDlv5dzIVaFdwSIEyIOLVrULMa9s
 zBDcxQNTxmKrXeKw=
X-Received: by 2002:adf:df8f:0:b0:314:c99:cd2d with SMTP id
 z15-20020adfdf8f000000b003140c99cd2dmr2028150wrl.10.1688120747603; 
 Fri, 30 Jun 2023 03:25:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhr3scCyf0WgQCu8+UeqpOKsKGqUy1eQJyrk2c/YFa/m9bAcYndO79dBD4FZ6HjLnArBGKVQ==
X-Received: by 2002:adf:df8f:0:b0:314:c99:cd2d with SMTP id
 z15-20020adfdf8f000000b003140c99cd2dmr2028141wrl.10.1688120747338; 
 Fri, 30 Jun 2023 03:25:47 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d4533000000b0030aded83385sm18010370wra.27.2023.06.30.03.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:25:46 -0700 (PDT)
Date: Fri, 30 Jun 2023 06:25:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230630062414-mutt-send-email-mst@kernel.org>
References: <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
> Indeed. Everyone uses bluetooth these days. I for one is happy that
> the jack is gone (and they were bold enough to do it while Samsung and
> others still carry the useless port ) :-)

🤦🏻


