Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E83737308
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBfGL-0005iJ-VP; Tue, 20 Jun 2023 13:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qBfGJ-0005iA-QB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:35:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qBfGH-0000a2-PE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:35:27 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KHW7s4008669
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 17:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8lhkeSb96aMorNOzWF2MKIMwVnP8NNfUJAArzuGMgK8=;
 b=j6hbbaZVm+ey3b1JhJqbq0g/juu+Wxg4nD9kna5bdyaNvZ8wRNq+6oJMfFVtP6dzdxuz
 4SgV89ojz0wl53c5crAQJMQb8IJIh2NztmrwrGyhiTWsfu2iciNT3KglYyzft9m33wks
 xROryTona3enuqPNfJu9KbX4nim1RmhWp52pmzIFm10DvjNty/D19cE7viO7LL//lhDC
 9iq1UR475792x9RM9ZGoW9AV+/74NQumdBDNeUMF16CnPXR0gJcG9ARCMLtCcweXzDEV
 afz6HKWl3JxRf6pAChni65LehlIbow0T45XMfrNRFnBCzdnC6kknoc14moG8Li9HZsSp KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbf1ujyp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 17:35:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35KHBcwE021509
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 17:35:21 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbf1ujynp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 17:35:21 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35KERa3s020766;
 Tue, 20 Jun 2023 17:35:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f59pw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 17:35:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35KHZHLJ39846154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 17:35:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 764F62004B;
 Tue, 20 Jun 2023 17:35:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34EF220040;
 Tue, 20 Jun 2023 17:35:17 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown
 [9.171.61.195]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jun 2023 17:35:17 +0000 (GMT)
Message-ID: <d6a79a1d2159e0659cd0ed6ff545bf577c05bad3.camel@linux.ibm.com>
Subject: Re: [PATCH] git-submodule.sh: allow running in validate mode
 without previous update
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 20 Jun 2023 19:35:16 +0200
In-Reply-To: <20230618212039.102052-1-pbonzini@redhat.com>
References: <20230618212039.102052-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KmCYtxBmNYrt5ks29og84uiFA6XCTdao
X-Proofpoint-GUID: j30A9Sbfn8l8qgpB7QDIssHjylkHXbNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200154
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, 2023-06-18 at 23:20 +0200, Paolo Bonzini wrote:
> The call to git-submodule.sh done in configure may happen without a
> previous checkout of the roms/SLOF submodule, or even without a
> previous run of the script.
>=20
> So, handle creating a .git-submodule-status file even in validate
> mode.  If git is absent, ensure that all passed directories exists
> (because you should be in a fresh untar and will not have stale
> arguments to git-submodule.sh) but do no other checks.  If git
> is present, ensure that .git-submodule-status contains an entry
> for all submodules passed on the command line.
>=20
> With this change, "ignore" mode is not needed anymore.
>=20
> Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Fixes: b11f9bd96f4 ("configure: move SLOF submodule handling to pc-bios/s=
390-ccw", 2023-06-06)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                |  2 +-
>  scripts/git-submodule.sh | 72 ++++++++++++++++++++++------------------
>  2 files changed, 41 insertions(+), 33 deletions(-)
>=20
> diff --git a/configure b/configure
> index 86363a7e508..2b41c49c0d1 100755
> --- a/configure
> +++ b/configure
> @@ -758,7 +758,7 @@ done
> =20
>  if ! test -e "$source_path/.git"
>  then
> -    git_submodules_action=3D"ignore"
> +    git_submodules_action=3D"validate"
>  fi
> =20
>  # test for any invalid configuration combinations
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 11fad2137cd..c33d8fe4cac 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -9,13 +9,22 @@ command=3D$1
>  shift
>  maybe_modules=3D"$@"
> =20
> -# if not running in a git checkout, do nothing
> -test "$command" =3D "ignore" && exit 0
> -
> +test -z "$maybe_modules" && exit 0
>  test -z "$GIT" && GIT=3D$(command -v git)
> =20
>  cd "$(dirname "$0")/.."
> =20
> +no_git_error=3D
> +if test -n "$maybe_modules" && ! test -e ".git"; then
> +    no_git_error=3D'no git checkout exists'
> +elif test -n "$maybe_modules" && test -z "$GIT"; then
> +    no_git_error=3D'git binary not found'
> +fi

No need to test -n "$maybe_modules" if you exit early above.

> +
> +is_git() {
> +    test -z "$no_git_error"
> +}
> +
>  update_error() {
>      echo "$0: $*"
>      echo
> @@ -34,7 +43,7 @@ update_error() {
>  }
> =20
>  validate_error() {
> -    if test "$1" =3D "validate"; then
> +    if is_git && test "$1" =3D "validate"; then
>          echo "GIT submodules checkout is out of date, and submodules"
>          echo "configured for validate only. Please run"
>          echo "  scripts/git-submodule.sh update $maybe_modules"
> @@ -51,42 +60,41 @@ check_updated() {
>      test "$CURSTATUS" =3D "$OLDSTATUS"
>  }
> =20
> -if test -n "$maybe_modules" && ! test -e ".git"
> -then
> -    echo "$0: unexpectedly called with submodules but no git checkout ex=
ists"
> -    exit 1
> +if is_git; then
> +    test -e $substat || touch $substat
> +    modules=3D""
> +    for m in $maybe_modules
> +    do
> +        $GIT submodule status $m 1> /dev/null 2>&1
> +        if test $? =3D 0
> +        then
> +            modules=3D"$modules $m"
> +            grep $m $substat > /dev/null 2>&1 || $GIT submodule status $=
module >> $substat
> +        else
> +            echo "warn: ignoring non-existent submodule $m"

What is the rational for ignoring non-existing submodules, i.e. how do the =
arguments to
the script go stale as you say in the patch description?
I'm asking because the fedora spec file initializes a new git repo in order=
 to apply
patches so the script exits with 0.
Nothing that cannot be worked around ofc.

> +        fi
> +    done
> +else
> +    modules=3D$maybe_modules
>  fi
> =20
> -if test -n "$maybe_modules" && test -z "$GIT"
> -then
> -    echo "$0: unexpectedly called with submodules but git binary not fou=
nd"
> -    exit 1
> -fi
> -
> -modules=3D""
> -for m in $maybe_modules
> -do
> -    $GIT submodule status $m 1> /dev/null 2>&1
> -    if test $? =3D 0
> -    then
> -        modules=3D"$modules $m"
> -    else
> -        echo "warn: ignoring non-existent submodule $m"
> -    fi
> -done
> -
>  case "$command" in
>  status|validate)
> -    test -f "$substat" || validate_error "$command"
> -    test -z "$maybe_modules" && exit 0
>      for module in $modules; do
> -        check_updated $module || validate_error "$command"
> +        if is_git; then
> +            check_updated $module || validate_error "$command"
> +        elif ! test -d $module; then

archive-source.sh creates an empty directory for e.g. roms/SLOF,
so this check succeeds even if the submodule sources are unavailable.
Something like

        elif ! test -d $module || test -z "$(ls -A "$module")"; then

works.

> +            echo "$0: sources not available for $module and $no_git_erro=
r"
> +            validate_error "$command"
> +        fi
>      done
> -    exit 0
>      ;;
> +
>  update)
> -    test -e $substat || touch $substat
> -    test -z "$maybe_modules" && exit 0
> +    is_git || {
> +        echo "$0: unexpectedly called with submodules but $no_git_error"
> +        exit 1
> +    }
> =20
>      $GIT submodule update --init $modules 1>/dev/null
>      test $? -ne 0 && update_error "failed to update modules"


