Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F19F7C874C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIjN-000697-QV; Fri, 13 Oct 2023 10:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrIin-0005zm-Sj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:00:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrIil-000244-CZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:00:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40776b200e5so1234425e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205653; x=1697810453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7YNZjJ5WtEYZoYNyQOQy4cWrF9ujWRZOM5yC+Rf8lDk=;
 b=qCQCJqp9zhvMJTwWtTo8k9K3Qd3Bvmum9NMBeGjcCtU74rME1cV5yUU94zFOMGSdtu
 /WjD/OHE728cm4AlVjwC5oJ0d5vPAflWkYw5gbtm8uW+l7uQI3DpN41hcIluXAp1DtHh
 wOC+vZUfRYmHplo0k75rk/N7GOcyzdrcP0t6dh3IPo3hVWGomJ7rZZHqo/0xP3tAc5Q4
 15ySC5pJ2d+s66pSh48cKac3/x1Rj1jhorQo3HCeaGtaQr0YEuPHJzMiUH2VifYpKHlr
 d5wWVFkUqjdgodRq9AIXMLxATORqwm6nF9neZo7Nh8bpAP7y36LxuRRqKogP55CahhT0
 Os4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205653; x=1697810453;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YNZjJ5WtEYZoYNyQOQy4cWrF9ujWRZOM5yC+Rf8lDk=;
 b=l5p/iFUDAL9cPGUj0D83Z8Kmd2XSPKi+1IG3Fi1HjBrKV2f/jlf38VrcXo4kOz2fJG
 lpO6a4AjL1xURCg7as4apdM5tpqyz1VoWIHHbPE0EZwg22BwaLV6soc0In2G3+j9c1ND
 gAVvQNNjCKCRrj0zi2ezozfiysShO2nyFrG/0iMyyJ10WA9NWBMk3noLsc284uzdUsao
 +Rnb3k7PEkTCX5ChGXqKSjYBekIpV4AKlto0SjoqtjH+a99iStrhaqKv/Yf2NQ1EzhoZ
 HqEFpARTeK1jXq5o7YnniGiMlrR3XVdQLffbfKYGmKDzPzTQ24zXD949dZ4tnkVGQhKO
 OzRg==
X-Gm-Message-State: AOJu0YxMOg83N/2o+ypHeELckAdQSP+TaiTlpxu0diyg+IwpZC5HkKLa
 H6kUA1XKmazas7gtXgcPUGL43w==
X-Google-Smtp-Source: AGHT+IHgJzSjXkbLYYOThkoHv7TfpOQZ6RSl+I7zDhZOPG+5Bm8lvcKrzA8om89IOcRK3bi97VdK2w==
X-Received: by 2002:a05:600c:15cc:b0:407:6120:cdec with SMTP id
 v12-20020a05600c15cc00b004076120cdecmr6653107wmf.38.1697205653601; 
 Fri, 13 Oct 2023 07:00:53 -0700 (PDT)
Received: from meli.delivery (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d4903000000b0031fa870d4b3sm20813776wrq.60.2023.10.13.07.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 07:00:53 -0700 (PDT)
Date: Fri, 13 Oct 2023 16:59:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 
Subject: Re: [RFC PATCH v3 00/78] Strict disable implicit fallthrough
User-Agent: meli 0.8.2
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <a4f64040-9812-40b2-9287-0c971b4bec4d@linaro.org>
In-Reply-To: <a4f64040-9812-40b2-9287-0c971b4bec4d@linaro.org>
Message-ID: <2h09f.7ino2iyatld@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Richard,

On Fri, 13 Oct 2023 16:52, Richard Henderson <richard.henderson@linaro.org> wrote:
>Did this catch any new problems?  If not, I really don't see the 
>benefit.
>The compiler comment matching appears to be sufficient.

As the cover letter states, this is a code style change. See "Background 
- Motivation" section.

--
Manos

