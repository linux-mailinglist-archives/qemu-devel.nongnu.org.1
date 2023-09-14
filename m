Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E17A0757
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnKK-00045i-4g; Thu, 14 Sep 2023 10:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnKI-00045Q-MB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:28:14 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnKG-0006d5-QF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:28:14 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-501cba1ec0aso1791739e87.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694701691; x=1695306491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S8aAywSCd7C1AuAEz2tlGW1HKA57LkEEJMI6pmFpASU=;
 b=d4/HwgN0A7f9RhklzBJPP0hFALTOA6GMs098e8dbdsQlJrtFkb4/fIgf/nIGSGiviQ
 +FIg44E5bQUrLAPEF18QI3prDwHby0JqNwQwdcXDSDk2ZkYloJdPy2saPheDEyG0rHAg
 zeM8XotbLug14JnmwYpV7fw4+Ig07IeaZemYlvjVaNGNoKPJVQE5Te4ayzKAI74p3x90
 F5o7c1iGdU34LfP6azvQkbk36S74kQAcp6oSQ5QEU/J3iXFNO2NmWZT9zQRwU/kieK1x
 ap8jVK7Hn4qgqu3QPLqHk2wWrwuS6+L4Y87EyNsPwsOLt7jkC1luaBJzMeI8gb0DTZhM
 oG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694701691; x=1695306491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S8aAywSCd7C1AuAEz2tlGW1HKA57LkEEJMI6pmFpASU=;
 b=ZG4g4ggiDPxNXEuqWjiwLbfyeuoypibl/SqrplXeVvhkjHB54Gs+eydttnnxnQCagS
 hFkUJ9YvEVD1aI/0woy1RmKNrzI5NuHIw/kscxpxYxcMEVDoNM2fZtKFGpnxfD6sxbQs
 u8+9oy06DJcQcN5CF9EUMpOumAHtbfd3Xha9GOFMa/IvGcJLZXEOpou8IkXlGg9SuvZy
 kWtQe12bFnv0am0nvd0/k6H+OsNWcrkyAUxhi8qTVDFSDI5uU32E/6yYZgtPOrMpjrmq
 RT8la+NRCpoBzhxu7SnqsoeNSU2Ij6VIVvh4iDlDfYaFepaNfwMA4p6Zh4Si9AfwLkrh
 cqPg==
X-Gm-Message-State: AOJu0Yxy28Yo7Pht9tUvJHS0e+TuBhlLL43XZ3O4ev5T8jcbxCFKaMm8
 v0vR0k/yezizBDpJ73D/NoBVXRs14798d5+9V8MQMQ==
X-Google-Smtp-Source: AGHT+IHRPAAqJT+9cfsZcg0ytMocwwE89mrsl+zsdb6ycnFgW3o+eNXPG2pGXYzgQlo00hlB1x6+cbD0PInuvCD2yNA=
X-Received: by 2002:a05:6512:686:b0:4f9:5519:78b8 with SMTP id
 t6-20020a056512068600b004f9551978b8mr5799105lfe.63.1694701690810; Thu, 14 Sep
 2023 07:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
In-Reply-To: <20230907181628.1594401-5-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2023 15:27:51 +0100
Message-ID: <CAFEAcA8TAzKKGSDyf1wmJfs2WfQXMdrO8BgXQFVobNfBCF_38A@mail.gmail.com>
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Thu, 7 Sept 2023 at 19:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> This commit adds support for ufs logical unit.
> The LU handles processing for the SCSI command,
> unit descriptor query request.
>
> This commit enables the UFS device to process
> IO requests.
>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: beacc504376ab6a14b1a3830bb3c69382cf6aebc.1693980783.git.jeuk20.kim@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Hi; Coverity points out a buffer overrun (CID 1519051) in
this commit:

> @@ -52,12 +76,18 @@ typedef struct UfsParams {
>
>  typedef struct UfsHc {
>      PCIDevice parent_obj;
> +    UfsBus bus;
>      MemoryRegion iomem;
>      UfsReg reg;
>      UfsParams params;
>      uint32_t reg_size;
>      UfsRequest *req_list;
>
> +    UfsLu *lus[UFS_MAX_LUS];

The array lus[] is UFS_MAX_LUS in size...

> +    UfsWLu *report_wlu;
> +    UfsWLu *dev_wlu;
> +    UfsWLu *boot_wlu;
> +    UfsWLu *rpmb_wlu;
>      DeviceDescriptor device_desc;
>      GeometryDescriptor geometry_desc;
>      Attributes attributes;

> @@ -716,9 +834,11 @@ static const RpmbUnitDescriptor rpmb_unit_desc = {
>
>  static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
>  {
> +    UfsHc *u = req->hc;
>      uint8_t lun = req->req_upiu.qr.index;
>
> -    if (lun != UFS_UPIU_RPMB_WLUN && lun > UFS_MAX_LUS) {
> +    if (lun != UFS_UPIU_RPMB_WLUN &&
> +        (lun > UFS_MAX_LUS || u->lus[lun] == NULL)) {

...but here the guard is "> UFS_MAX_LUS", which permits
lun == UFS_MAX_LUS, which will index off the end of the array here...

>          trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, lun);
>          return UFS_QUERY_RESULT_INVALID_INDEX;
>      }
> @@ -726,8 +846,8 @@ static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
>      if (lun == UFS_UPIU_RPMB_WLUN) {
>          memcpy(&req->rsp_upiu.qr.data, &rpmb_unit_desc, rpmb_unit_desc.length);
>      } else {
> -        /* unit descriptor is not yet supported */
> -        return UFS_QUERY_RESULT_INVALID_INDEX;
> +        memcpy(&req->rsp_upiu.qr.data, &u->lus[lun]->unit_desc,
> +               sizeof(u->lus[lun]->unit_desc));

...and here.

>      }
>
>      return UFS_QUERY_RESULT_SUCCESS;

Either the array needs to be larger, or the guard should be ">=".

thanks
-- PMM

